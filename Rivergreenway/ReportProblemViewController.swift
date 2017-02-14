//
//  ReportProblemViewController.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 11/28/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit
import CoreLocation

class ReportProblemViewContoller: DraweredViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{

    private var latitude : Double?
    private var longitude : Double?
    
    func animateProblemType(textField: UITextField, up: Bool)
    {
        let movementDistance:CGFloat = -160
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    @IBAction func didBeginEditingProblemTypeTextField(sender: UITextField) {
        self.animateProblemType(problemType, up:true)
        let problemTypePickerView:UIPickerView = UIPickerView()
        problemTypePickerView.dataSource = self
        problemTypePickerView.delegate = self
        sender.inputView = problemTypePickerView
    }
    
    @IBAction func didEndEditingProblemTextField(sender: UITextField) {
        self.animateProblemType(problemType, up:false)
    }
    
    @IBOutlet weak var titleProblem: UITextField!
    
    func animateTitleProblem(textField: UITextField, up: Bool)
    {
        let movementDistance:CGFloat = -210
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    @IBAction func didBeginEditingTitleProblemTextField(sender: UITextField) {
        self.animateTitleProblem(titleProblem, up:true)
    }
    
    
    @IBAction func didEndEditingTitleProblemTextField(sender: UITextField) {
        self.animateTitleProblem(titleProblem, up:false)
    }
    
    @IBOutlet weak var additionalDetails: UITextField!
    
    func animateAdditionalDetails(textField: UITextField, up: Bool)
    {
        let movementDistance:CGFloat = -240
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    @IBAction func didBeginEditingAdditionalDetailsTextField(sender: UITextField) {
        self.animateAdditionalDetails(additionalDetails, up:true)
    }
    
    @IBAction func didEndEditingAdditionalDetailsTextField(sender: UITextField) {
        self.animateAdditionalDetails(additionalDetails, up:false)
    }
    
    @IBOutlet weak var problemType: UITextField!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func openPhotoLibrary(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        
        let locManager = CLLocationManager()
        var currentLocation: CLLocation!
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            currentLocation = locManager.location
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
        }
    }
    
    var pickerDataSource = ["Tree/Branch", "Glass", "High Water", "Vandalism", "Litter", "Overgrown Trail", "Trash Full", "Pothole", "Other"];
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        problemType.text = pickerDataSource[row]
    }
    
    
    //Action once the Submit button is pressed
    @IBAction func pressSubmitButton(sender: AnyObject) {
        
        if(imagePicked.image == nil || problemType.text == "" || titleProblem.text == "")
        {
            let alert = UIAlertController(title: "Cannot Submit Problem", message: "Please enter information for all necessary fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        else{
            let alert = UIAlertController(title: "Submit Problem",
                                          message: "Are you sure you submit this problem?",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: submitHandler))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)        }
        
    }
    
    //Where the fields are sent on submit
    func submitHandler(action: UIAlertAction) {

        SVProgressHUD.show()
        
        //Where calling the web API will happen
        let newProblem = ReportProblem(problem: problemType.text!)

        WebStore.reportProblem(newProblem,
                               errorCallback: {error in
                                dispatch_async(dispatch_get_main_queue(),{
                                    self.onReportProblemError(error)
                                })
            }, successCallback: {
                dispatch_async(dispatch_get_main_queue(),{
                    self.onReportProblemSuccess()
                })
            }
        )
    }

    /**
     Callback for a successful transmission of the activity to the server.
     */
    func onReportProblemSuccess() {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Thank You.", message: "You have successfully submitted the problem.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    /**
     Callback for an unsuccessful transmission of the activity to the server.
     Displays an alert view to alert the user that their connection to the
     server failed.
     */
    func onReportProblemError(error: WebStoreError) {
        SVProgressHUD.dismiss()
        ViewControllerUtilities.displayServerConnectionErrorAlert(self, message: error.description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}