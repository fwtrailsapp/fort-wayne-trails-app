//
//  CreateAccountViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/6/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class CreateAccountViewController: BaseTableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBAction func createButtonPressed(sender: UIBarButtonItem) {
        
        if (usernameField.text != nil && passwordField.text != nil && confirmPasswordField.text != nil) && (!usernameField.text!.isEmpty && !passwordField.text!.isEmpty && !confirmPasswordField.text!.isEmpty) {
            
            // ensure the the password and confirm password fields match
            if passwordField.text != confirmPasswordField.text {
                let alert = UIAlertController(title: "Cannot Create Account", message: "Please enter a matching confirmation password.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: false, completion: nil)
                return
            }
            
            SVProgressHUD.show()
            
            let password = passwordField.text!
            let birthYear = (birthYearField.text == nil) ? nil : Int(birthYearField.text!)
            let height = (heightField.text == nil) ? nil : Double(heightField.text!)
            let weight = (weightField.text == nil) ? nil : Double(weightField.text!)
            let sex: Sex? = (sexSegmentedControl.selectedSegmentIndex == 0) ? nil : Sex.all[sexSegmentedControl.selectedSegmentIndex - 1]
            
            let newAccount = Account(username: usernameField.text!, birthYear: birthYear, height: height, weight: weight, sex: sex)
            
            WebStore.createAccount(newAccount, password: password,
                errorCallback: {error in
                    dispatch_async(dispatch_get_main_queue(),{
                        self.onAccountCreateError(error)
                    })
                }, successCallback: {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.onAccountCreateSuccess()
                    })
                }
            )
        } else {
            let alert = UIAlertController(title: "Cannot Create Account", message: "Please enter a username and password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Discard Changes",
            message: "Are you sure you wish to discard these changes?",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
        
    @IBAction func didBeginEditingDateTextField(sender: UITextField) {
        let yearPickerView:UIPickerView = UIPickerView()
        yearPickerView.dataSource = self
        yearPickerView.delegate = self
        sender.inputView = yearPickerView
    }
    
    @IBOutlet weak var birthYearField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    
    private var years: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year], fromDate: date)
        
        let currYear =  Int(components.year)
        
        for year in 1900...currYear {
            years.append(String(year))
        }
    }
    
    func onAccountCreateSuccess() {
        SVProgressHUD.dismiss()
        ViewControllerUtilities.transitionDrawered(self, destination: ViewIdentifier.RecordActivityNavController)
    }
    
    func onAccountCreateError(error: WebStoreError) {
        SVProgressHUD.dismiss()
        ViewControllerUtilities.displayServerConnectionErrorAlert(self, message: error.description)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        birthYearField.text = years[row]
    }
    
    func discardHandler(action: UIAlertAction) {
        ViewControllerUtilities.transition(self, destination: ViewIdentifier.LoginView)
    }
}
