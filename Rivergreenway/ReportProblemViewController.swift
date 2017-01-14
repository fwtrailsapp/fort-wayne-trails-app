//
//  ReportProblemViewController.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 11/28/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class ReportProblemViewContoller: DraweredViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        self.dismissViewControllerAnimated(true, completion: nil);
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
        let image = imagePicked.image
        let problem = problemType.text
        let title = titleProblem.text
        let additional = additionalDetails.text
        
        let account = ViewControllerUtilities.getAccount()!
        let username = account.username
        
        
        
        
        
        //Where calling the web API will happen
        
        
        let alert = UIAlertController(title: "Thank You.", message: "You have successfully submitted the problem.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
        
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}