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
    
    @IBOutlet weak var problemType: UITextField!
    
    @IBAction func didBeginEditingProblemTypeTextField(sender: UITextField) {
        self.animateProblemType(problemType, up:true)
        let problemTypePickerView:UIPickerView = UIPickerView()
        problemTypePickerView.dataSource = self
        problemTypePickerView.delegate = self
        sender.inputView = problemTypePickerView
    }

    var pickerDataSource = ["Tree/Branch", "Broken Glass", "High Water", "Vandalism", "Litter", "Overgrown Brush", "Trash Full", "Pothole", "Other"];
    
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
    
    @IBAction func didEndEditingProblemTextField(sender: UITextField) {
        self.animateProblemType(problemType, up:false)
    }
    
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
    
    @IBOutlet weak var titleProblem: UITextField!
    
    @IBAction func didBeginEditingTitleProblemTextField(sender: UITextField) {
        self.animateTitleProblem(titleProblem, up:true)
    }
    
    
    @IBAction func didEndEditingTitleProblemTextField(sender: UITextField) {
        self.animateTitleProblem(titleProblem, up:false)
    }
    
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
    
    @IBOutlet weak var additionalDetails: UITextField!
    
    @IBAction func didBeginEditingAdditionalDetailsTextField(sender: UITextField) {
        self.animateAdditionalDetails(additionalDetails, up:true)
    }
    
    @IBAction func didEndEditingAdditionalDetailsTextField(sender: UITextField) {
        self.animateAdditionalDetails(additionalDetails, up:false)
    }
    
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
   
    @IBOutlet weak var imageWillShowHere: UILabel!

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        imageWillShowHere.hidden = true
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
        
        let curr = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy - h:mm a"
        let date = formatter.stringFromDate(curr)
        
        let account = ViewControllerUtilities.getAccount()!
        
        let imageData = UIImagePNGRepresentation(imagePicked.image!)
        let imgLink = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        //Where calling the web API will happen
        let newProblem = ReportProblem(type: problemType.text!, description: additionalDetails.text!, active: 1, imgLink: imgLink, latitude: latitude, longitude : longitude, title: titleProblem.text!, date: date, username: account.username, notes: nil, dateClosed: nil)

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