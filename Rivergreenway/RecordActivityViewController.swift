//
//  TrailActivityViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class RecordActivityViewController: DraweredViewController, CLLocationManagerDelegate,UIPopoverPresentationControllerDelegate, GMSMapViewDelegate, StartPauseDelegate, ResumeFinishDelegate {

    // MARK : - Properties
    
    @IBOutlet weak var singleButtonContainerView: UIView!
    @IBOutlet weak var doubleButtonContainerView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var controlPanelView: UIView!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    private var overlayer: Overlayer?
    private var recorder: TrailActivityRecorder?
    private let locationManager = CLLocationManager()
    private var displayTime:NSTimeInterval = 0
    
    private var polylines: [GMSPolyline] = [GMSPolyline]()
    
    private var startPauseController: StartPauseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.shadowColor = UIColor.blackColor().CGColor
        controlPanelView.layer.shadowOpacity = 1
        controlPanelView.layer.shadowOffset = CGSizeZero
        controlPanelView.layer.shadowRadius = 10
        controlPanelView.layer.shouldRasterize = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval( 1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        
        overlayKML()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
        
        mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: mapView.camera.zoom)
        
        if recorder != nil && recorder!.isRecording() {
            do {
                try recorder!.update(myLocation)
            }
            catch {
                
            }
            if let polyline = polylines.last {
                polyline.path = recorder!.getSegment()
            }
            updateStatistics()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == ViewIdentifier.START_PAUSE_SEGUE.rawValue {
            startPauseController = segue.destinationViewController as? StartPauseViewController
            startPauseController!.setDelegate(self)
        } else if segue.identifier! == ViewIdentifier.RESUME_FINISH_SEGUE.rawValue {
            let resumeFinishController = segue.destinationViewController as! ResumeFinishViewController
            resumeFinishController.setDelegate(self)
        }
    }
    
    // for popovers
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func updateStatistics() {
        if recorder != nil {
            distanceLabel.text = formatNumber(recorder!.getDistance())
            caloriesLabel.text = formatNumber(recorder!.getCalories())
            speedLabel.text = formatNumber(recorder!.getSpeed())
        } else {
            distanceLabel.text = formatNumber(0)
            caloriesLabel.text = formatNumber(0)
            speedLabel.text = formatNumber(0)
        }
    }
    
    func updateTime() {
        if recorder != nil && (recorder!.isRecording()) {
            displayTime++;
            durationLabel.text = Converter.getDurationAsString(displayTime)
        }
    }
    
    func swapContainerViews() {
        if recorder != nil && recorder!.getState() == TrailActivityState.Paused {
            singleButtonContainerView.alpha = 0
            doubleButtonContainerView.alpha = 1
        } else {
            singleButtonContainerView.alpha = 1
            doubleButtonContainerView.alpha = 0
        }
    }
    
    func start(exerciseType: ExerciseType) {
        do {
            recorder = TrailActivityRecorder(startTime: NSDate(), exerciseType: exerciseType)
            try recorder!.start()
            startNewPolyline()
        } catch {
            print("error starting")
        }
    }
    
    func pause() {
        do {
            try recorder!.pause()
        } catch {
            print("error pausing")
        }
        swapContainerViews()
    }
    
    func resume() {
        do {
            try recorder!.resume()
            swapContainerViews()
            startNewPolyline()
        } catch {
            print("error resuming")
        }
    }
    
    func finish() {
            displayFinishPrompt()
    }
    
    func overlayKML() {
        overlayer = Overlayer(mapView: mapView)
        do {
            try self.overlayer!.loadKMLFromURL("https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml")
        } catch {
            print("caught dis shit")
        }
    }
    
    // Helper method to format numbers
    func formatNumber(number: Double) -> String {
        return String(format: "%.2f", number)
    }
    
    func displayFinishPrompt() {
        let alert = UIAlertController(title: "Finish Activity", message: "Do you wish to save or discard the activity?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: saveHandler))
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    func saveHandler(action: UIAlertAction) {
        displaySummary()
    }
    
    func discardHandler(action: UIAlertAction) {
        resetRecorder()
        clearPath()
        updateStatistics()
        durationLabel.text = Converter.getDurationAsString(displayTime)
    }
    
    func displaySummary() {
        let trailActivity = recorder!.getActivity()
        let alert = UIAlertController(title: "Activity Summary", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: summaryOkHandler))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Left
        
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
    
    func summaryOkHandler(action: UIAlertAction) {
        if recorder != nil {
            let webStore = WebStore()
            SVProgressHUD.show()
            webStore.createNewActivity("ggrimm", act: recorder!.getActivity(),
                errorCallback: {error in
                    dispatch_async(dispatch_get_main_queue(),{
                        self.discardHandler(action)
                        SVProgressHUD.dismiss()
                        self.displayServerConnectionErrorAlert("Failed to send activity data to server.")
                    })
                }, successCallback: {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.discardHandler(action)
                        SVProgressHUD.dismiss()
                    })
            })
        }
    }
    
    func startNewPolyline() {
        if recorder != nil {
            let polyline = GMSPolyline(path: recorder!.getSegment())
            polyline.map = mapView
            polylines.append(polyline)
        }
    }
    
    func clearPath() {
        for polyline in polylines {
            polyline.path = nil
        }
        polylines.removeAll()
    }
    
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
    
    func getFormattedSummary(activity: TrailActivity) -> String {
        var summary = ""
        let startDate = activity.getStartTime()
        summary += "Exercise Type: \(activity.getExerciseType())"
        summary += "\nStart: \(startDate)"
        summary += "\nDuration: \(Converter.getDurationAsString(activity.getDuration()))"
        summary += "\nDistance: \(formatNumber(activity.getDistance()))"
        summary += "\nCalories: \(formatNumber(activity.getCaloriesBurned()))"
        
        return summary
    }
}
