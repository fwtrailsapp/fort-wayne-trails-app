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
            
            if usernameField.text!.characters.count > 20 {
                let alert = UIAlertController(title: "Cannot Create Account", message: "Please enter a username that is 20 characters or less.", preferredStyle: UIAlertControllerStyle.Alert)
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
        WebStore.login(usernameField.text!, password: passwordField.text!,
                       errorCallback: {error in
                        dispatch_async(dispatch_get_main_queue(),{
                            ViewControllerUtilities.genericErrorHandler(self, error: error)
                        })
            },
                       successCallback: {
                        dispatch_async(dispatch_get_main_queue(),{
                            self.onLoginSuccess()
                        })
            }
        )
    }
    
    func onLoginSuccess() {
        WebStore.getAccount(
            errorCallback: {error in
                dispatch_async(dispatch_get_main_queue(),{
                    ViewControllerUtilities.genericErrorHandler(self, error: error)
                })
            },
            successCallback: { account in
                dispatch_async(dispatch_get_main_queue(),{
                    self.onGetAccountSuccess(account)
                })
            }
        )
    }
    
    func onGetAccountSuccess(account: Account) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // set the account the app will use throughout
        appDelegate.account = account
        
        ViewControllerUtilities.transitionDrawered(self, destination: ViewIdentifier.RecordActivityNavController)
        SVProgressHUD.dismiss()
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