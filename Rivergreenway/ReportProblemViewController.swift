//
//  ReportProblemViewController.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 10/12/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class ReportProblemViewController: DraweredViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var openCameraButton: UIButton!
    @IBOutlet weak var textfieldReportProblem: UITextField!
    @IBOutlet weak var openPhotoLibraryButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var problemType: UIPickerView!
    
    @IBAction func openCameraButton(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
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
    }
    
    @IBAction func submitButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}