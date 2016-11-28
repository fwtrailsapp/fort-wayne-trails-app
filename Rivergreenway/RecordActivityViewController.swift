//
// Copyright (C) 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//  TrailActivityViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 
 RecordActivityViewController controls the Record Activity View, which is the
 view in which users record their activities on the trails using GPS. To enable
 the recording, this class communicates with a TrailActivityRecorder object
 
 The view enables users to control their recording through transitions between recording
 states: Created, Started, Paused, Resumed, and Finished (see: TrailActivityState.swift).
 While users record their activities, and the state of their recording is either 'Started'
 or 'Resumed', they can view live updates for the duration of their activity, the distance
 they have traveled, their current speed, and calories burned. Regardless of the recording
 state, they will also receive live location updates provided by GPS data and displayed
 on a Google Maps GMSMapView object.
 
 In addition to live location, speed, distance, duration, and calories burned updates, the
 view will also overlay a map of the Fort Wayne Regional Trail Network trails as well as an
 overlay of the user's path for the current activity. If the user pauses the recording, the
 live updates will pause as well - including the user's path updates. If a user moves while
 their recording is paused, there will be gaps in their path overlay on the map.
 
 When a user decides to finish recording their activity, they are presented with two options
 for the fate of their activity: Discard or Save. If they discard the activity, all of the
 activity data will be lost. If the user opts to save the activity, its data will be sent
 to the central server using the REST API. In any event, whether the activity is saved or
 discarded, the view is updated: the user's path on the GMSMapView Object is erased, as is
 the display of their activity duration, distance, speed, and calories burned.
 
 */
class RecordActivityViewController: DraweredViewController, CLLocationManagerDelegate,UIPopoverPresentationControllerDelegate, GMSMapViewDelegate, StartPauseDelegate, ResumeFinishDelegate {
    
    // MARK : - Properties
    
    @IBOutlet weak var startPauseButtonContainerView: UIView!
    @IBOutlet weak var resumeFinishButtonContainerView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var controlPanelView: UIView!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    // KML overlayer object for overlaying
    // the city's trail network map
    private var overlayer: Overlayer?
    private var recorder: TrailActivityRecorder?
    
    // necessary for getting permission for the app
    // to receive location updates
    private let locationManager = CLLocationManager()
    
    // Stores the recording time for the activity -
    // is meant to be updated every second
    private var displayTime: NSTimeInterval = 0
    
    // list of polylines drawn on the map
    private var polylines: [GMSPolyline] = [GMSPolyline]()
    
    private var startPauseController: StartPauseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a shadow to the control panel (where calories, duration, etc.
        // are displayed) in hopes it will look cool
        addControlPanelShadow()
        
        // set this view controller as the location manager delegate
        locationManager.delegate = self
        
        // if necessary, the app will pop up a little window
        // to request authorization to access the user's location
        locationManager.requestWhenInUseAuthorization()
        
        // enable 'My Location' and the 'My Location' button on the map view
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        // sets this view controller as an observer for the myLocation property of
        // the map view.
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        // schedule a timer to update the displayed activity duration every second
        let _ = NSTimer.scheduledTimerWithTimeInterval( 1.0, target: self, selector: #selector(RecordActivityViewController.tick), userInfo: nil, repeats: true)
        
        overlayKML()
    }
    
    /**
     This method is called whenever the myLocation property on the GMSMapView object is changed.
     
     When the location is changed, this method:
     - Updates the GMSMapView camera to center on the user's new location
     - Updates the GMSPolyline that displays the user's path
     - Updates the statistics display
     - Updates the TrailActivityRecorder
     */
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
        
        mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: mapView.camera.zoom)
    }
    
    /**
     This method is called once per second. It updates the current activity time and the other
     displayed fields. To maintain the accuracy of the time, it is updated first.
     */
    func tick() {
        updateTime()
        updateRecording()
    }
    
    /**
     Updates the trail activity recording using the user's current location.
     */
    func updateRecording() {
        let myLocation = locationManager.location
        if myLocation != nil {
            // update the recorder with the new location if it is currently recording
            if recorder != nil && recorder!.isRecording() {
                do {
                    try recorder!.update(myLocation!)
                }
                catch {
                    // wait till next update
                }
                
                // the polyline path needs to be refreshed
                if let polyline = polylines.last {
                    polyline.path = recorder!.getSegment()
                }
                updateStatistics()
            }
        }
    }
    
    /**
     Adds a shadow to the 'Control Panel' (the portion of the screen that displays calories, duration, etc.).
     */
    func addControlPanelShadow() {
        controlPanelView.layer.shadowColor = UIColor.blackColor().CGColor
        controlPanelView.layer.shadowOpacity = 1
        controlPanelView.layer.shadowOffset = CGSizeZero
        controlPanelView.layer.shadowRadius = 10
        controlPanelView.layer.shouldRasterize = true
    }
    
    /**
     This method is called whenever this view controller (or its children) is segueing to
     another view controller.
     
     The Start/Pause button and is on a different view controller than the Resume and Finish
     buttons. When the Pause button is pressed, the StartPauseViewController is swapped out with
     the ResumeFinishViewController.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == ViewIdentifier.StartPauseSegue.rawValue {
            startPauseController = segue.destinationViewController as? StartPauseViewController
            startPauseController!.setDelegate(self)
        } else if segue.identifier! == ViewIdentifier.ResumeFinishSegue.rawValue {
            let resumeFinishController = segue.destinationViewController as! ResumeFinishViewController
            resumeFinishController.setDelegate(self)
        }
    }
    
    /**
     This method is needed to correctly display Popovers. For the RecordActivityViewController,
     the only popover used is for selecting exercise types at when a recording is started.
     */
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    /**
     Updates the statistics labels. If the activity recorder is not nil, then its values
     for distance, speed, and calories are populated into the labels. Duration is handled
     separately by a timer object to ensure that it is updated every second on the dot.
     
     Otherwise, the labels are populated with 0s.
     */
    func updateStatistics() {
        if recorder != nil {
            distanceLabel.text = Converter.doubleToString(recorder!.getDistance())
            caloriesLabel.text = Converter.doubleToString(recorder!.getCalories())
            speedLabel.text = Converter.doubleToString(recorder!.getSpeed())
        } else {
            distanceLabel.text = Converter.doubleToString(0)
            caloriesLabel.text = Converter.doubleToString(0)
            speedLabel.text = Converter.doubleToString(0)
        }
    }
    
    /**
     Increments the duration label by one if the recorder is currently
     recording (i.e. it is in the 'Resumed' or 'Started' state).
     */
    func updateTime() {
        if recorder != nil && (recorder!.isRecording()) {
            displayTime += 1;
            durationLabel.text = Converter.timeIntervalToString(displayTime)
            recorder?.updateDuration(displayTime)
        }
    }
    
    /**
     Swaps the StartPauseViewController with the ResumeFinishController by using the alpha property
     - it determines which view is on top and actually visible. The higher the alpha, the higher the
     view is.
     
     If the activity recorder is paused, then the ResumeFinishViewController needs to be displayed.
     Otherwise, the StartPauseViewController needs to be displayed.
     */
    func swapContainerViews() {
        if recorder != nil && recorder!.getState() == TrailActivityState.Paused {
            startPauseButtonContainerView.alpha = 0
            resumeFinishButtonContainerView.alpha = 1
        } else {
            startPauseButtonContainerView.alpha = 1
            resumeFinishButtonContainerView.alpha = 0
        }
    }
    
    /**
     This method is from the StartPauseDelegate protocol. When the start button is pressed in the
     StartPauseViewController, this method is called. It initializes the activity recorder
     and starts its recording. Additionally, it adds a new polyline to the map view to display
     the user's path.
     */
    func start(exerciseType: ExerciseType) {
        do {
            recorder = TrailActivityRecorder(startTime: NSDate(), exerciseType: exerciseType, BMR: ViewControllerUtilities.getAccount()!.BMR())
            try recorder!.start()
            startNewPolyline()
        } catch {
            print("error starting")
        }
    }
    
    /**
     This method is from the StartPauseDelegate protocol. When the pause button is pressed in the
     StartPauseViewController, this method is called. It swaps the StartPauseViewController with the
     ResumeFinishViewController, which gives the user the option to resume or finish recording their
     current activity. It also pauses the activity recorder.
     */
    func pause() {
        do {
            try recorder!.pause()
            swapContainerViews()
        } catch {
            print("error pausing")
        }
    }
    
    /**
     This method is from the ResumeFinishDelegate protocol. When the resume button is pressed in
     the ResumeFinishViewController, this method is called. It swaps the ResumeFinishViewController
     with the StartPauseViewController, starts a fresh polyline on the map for the user's path, and
     resumes the activity recorder.
     */
    func resume() {
        do {
            try recorder!.resume()
            swapContainerViews()
            startNewPolyline()
        } catch {
            print("error resuming")
        }
    }
    
    /**
     This method is from the ResumeFinishDelegate protocol. When the finish button is pressed in
     the ResumeFinishViewController, this method is called. It displays the finish alert view -
     the user is given the option to cancel, to discard the activity, or to save the activity.
     */
    func finish() {
        displayFinishPrompt()
    }
    
    /**
     Overlays the Fort Wayne Regional Trail Network KML onto the GMSMapView. Presently,
     the KML file is loaded via HTTPS from Jared Perry's Github account.
     */
    func overlayKML() {
        overlayer = Overlayer(mapView: mapView)
        do {
            try self.overlayer!.loadKMLFromURL("https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml")
        } catch {
            print("Couldn't load KML")
        }
    }
    
    /**
     When the user presses the 'Finish' button, they are given the option to save the activity,
     discard it, or to cancel and continue recording.
     */
    func displayFinishPrompt() {
        let alert = UIAlertController(title: "Finish Activity", message: "Do you wish to save or discard the activity?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: saveHandler))
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    /**
     Handler for the 'Save' option in the finish activity alert view. It displays another alert
     view, which contains a summary of the activity - distance traveled, activity type, etc.
     */
    func saveHandler(action: UIAlertAction) {
        displaySummary()
    }
    
    /**
     Handler for the 'Discard' option in the finish activity alert view. It resets the activity
     recorder object, clears the user's path from the map view, updates the statistics so they are
     set to 0, and resets the duration as well.
     */
    func discardHandler(action: UIAlertAction) {
        resetRecorder()
        clearPath()
        updateStatistics()
        durationLabel.text = Converter.timeIntervalToString(displayTime)
    }
    
    /**
     Displays the activity summary in an alert view.
     */
    func displaySummary() {
        let trailActivity = recorder!.getActivity()
        let alert = UIAlertController(title: "Activity Summary", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: summaryOkHandler))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Left
        
        // this justifies the text to the left (so it isn't awkwardly centered).
        let messageText = NSMutableAttributedString(
            string: getFormattedSummary(trailActivity),
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
                NSForegroundColorAttributeName : UIColor.blackColor()
            ]
        )
        
        alert.setValue(messageText, forKey: "attributedMessage")
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    /**
     Handles the 'Ok' button presses for the activity summary alert view. When the user
     finishes reading the summary for their activity, it is sent to the server.
     */
    func summaryOkHandler(action: UIAlertAction) {
        if recorder != nil {
            // SVProgressHUD is a 3rd party library for a simple spinner - indicates
            // activity.
            SVProgressHUD.show()
            let activity = recorder!.getActivity()
            WebStore.createNewActivity(activity,
                                       errorCallback: { error in
                                        dispatch_async(dispatch_get_main_queue(), {
                                            self.onActivityPostError(action, error: error)
                                        })
                }, successCallback: {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.onActivityPostSuccess(action)
                    })
            })
        }
    }
    
    /**
     Callback for a successful transmission of the activity to the server.
     */
    func onActivityPostSuccess(action: UIAlertAction) {
        self.discardHandler(action)
        SVProgressHUD.dismiss()
    }
    
    /**
     Callback for an unsuccessful transmission of the activity to the server.
     Displays an alert view to alert the user that their connection to the
     server failed.
     */
    func onActivityPostError(action: UIAlertAction, error: WebStoreError) {
        self.discardHandler(action)
        SVProgressHUD.dismiss()
        ViewControllerUtilities.displayServerConnectionErrorAlert(self, message: error.description)
    }
    
    /**
     Creates a new GMSPolyline for the user's activity recording. Typically, this
     is called when a user pauses, and then resumes, their activity recording.
     */
    func startNewPolyline() {
        if recorder != nil {
            let polyline = GMSPolyline(path: recorder!.getSegment())
            polyline.map = mapView
            polylines.append(polyline)
        }
    }
    
    /**
     Clears all of the user's polylines from the map view.
     */
    func clearPath() {
        for polyline in polylines {
            polyline.path = nil
        }
        polylines.removeAll()
    }
    
    /**
     Stops the recorder, and sets it to nil. Also resets the statistics labels and returns the
     RecordActivityViewController to its original state.
     */
    func resetRecorder() {
        do {
            try recorder!.stop()
            recorder = nil
            displayTime = 0
            startPauseController!.resetView()
            swapContainerViews()
        } catch {
            print("error stopping")
        }
    }
    
    /**
     Returns a cleanly formatted summary of the given activity.
     */
    func getFormattedSummary(activity: TrailActivity) -> String {
        var summary = ""
        let startDate = activity.getStartTime()
        summary += "Exercise Type: \(activity.getExerciseType())"
        summary += "\nStart: \(startDate)"
        summary += "\nDuration: \(Converter.timeIntervalToString(activity.getDuration()))"
        summary += "\nDistance: \(Converter.doubleToString(activity.getDistance()))"
        summary += "\nCalories: \(Converter.doubleToString(activity.getCaloriesBurned()))"
        
        return summary
    }
}