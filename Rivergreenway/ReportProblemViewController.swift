//Copyright (C) 2016 Jared Perry, Scott Weidenkopf and Neil Rawlins

//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute,sublicense,and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.//  ReportProblemViewController.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 11/28/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit
import CoreLocation

class ReportProblemViewContoller: DraweredViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{

    //Latitude and Longitude for the GPS coordinates
    private var latitude : Double?
    private var longitude : Double?
    
    //Type of problem that the user finds
    @IBOutlet weak var problemType: UITextField!
    
    @IBAction func didBeginEditingProblemTypeTextField(sender: UITextField) {
        self.animateProblemType(problemType, up:true) //Slides the page up so the user can see the screen and keyboard
        let problemTypePickerView:UIPickerView = UIPickerView()
        problemTypePickerView.dataSource = self
        problemTypePickerView.delegate = self
        sender.inputView = problemTypePickerView
    }

    //The preset types of problems the user can choose
    var pickerDataSource = ["Tree/Branch", "Broken Glass", "High Water", "Vandalism", "Litter", "Overgrown Brush", "Trash Full", "Pothole", "Other"];
    
    //These next four methods control the Picker View
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
    
    //Controls how high the page slides up so the keyboard will not overlap with the page.
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
    
    //A text field where the user will describe the problem in 1 sentence
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
    
    //Where the user will add any additional details about the problem. This field is optional for the user
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
    
    //The image view that will hold the UIImage
    @IBOutlet weak var imagePicked: UIImageView!
    
    //This outlet is used to change the text to "Retake Photo?" after an image is selected by the user.
    @IBOutlet weak var openCameraButton: UIButton!
    
    //This function opens the camera on the iPhone.
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
   
    //A label that is hidden after a user selects an image from the camera
    @IBOutlet weak var imageWillShowHere: UILabel!

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //Displays the image taken from the camera in the UIImage view
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        //Saves the image to the user's camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        //Hides the label
        imageWillShowHere.hidden = true
        //Hides the black border
        imagePicked.layer.borderWidth = 0.0
        //Changes the button text
        openCameraButton.setTitle("Retake Photo?", forState: .Normal)
        //Gets the GPS coordinates from the user
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
        
        let date = Converter.dateToString(NSDate())
        
        let account = ViewControllerUtilities.getAccount()!
        
        //This resizes the image to an appropriate size
        var resizedImage = imagePicked.image!
        resizedImage = self.resizeImage(resizedImage, targetSize: CGSizeMake(500.0, 500.0))
        //Changes the UIImage to a JPEG representation with a compression of 1 (least ammount of compression on a scale of 0.0 to 1.0, resulting in the highest quality)
        let imageData = UIImageJPEGRepresentation(resizedImage, 1.0)
        imageData?.length
        //Encodes the JPEG representation to a base64 string. This is decoded on the server and returned to a JPEG image.
        let imgLink = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)

        //Sends everything necessary to the server as a JSON object
        let newProblem = ReportProblem(type: problemType.text!, description: additionalDetails.text!, active: 1, imgLink: imgLink, latitude: latitude, longitude : longitude, title: titleProblem.text!, date: date, username: account.username, notes: "", dateClosed: "")

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

    //The function that resizes the image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /**
     Callback for a successful transmission of the activity to the server.
     */
    func onReportProblemSuccess() {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Thank You.", message: "You have successfully submitted the problem.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
        
        imagePicked.image = nil
        imagePicked.layer.borderWidth = 2.0
        imageWillShowHere.hidden = false
        problemType.text = ""
        titleProblem.text = ""
        additionalDetails.text = ""
        openCameraButton.setTitle("Open Camera", forState: .Normal)
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
        let borderColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
        imagePicked.layer.borderColor = borderColor.CGColor
        imagePicked.layer.borderWidth = 2.0    }
    
}