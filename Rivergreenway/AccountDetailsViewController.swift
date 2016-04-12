//
//  AccountDetailsViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/14/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class AccountDetailsViewController: DraweredTableViewController {

    // MARK : - Properties
    
    @IBOutlet weak var birthYearField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    private var newPassword: String?
    private var account: Account!
    private var newAccount: Account?
    
    // MARK : - Actions
    
    @IBAction func changePasswordPressed(sender: UIButton) {
        
        // initialize text fields
        var oldPasswordField: UITextField?
        var newPasswordField: UITextField?
        var newPasswordConfirmField: UITextField?
        
        let alert = UIAlertController(title: "Change Password", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
            handler: { action in
                self.passwordOkButtonPressed(oldPasswordField!.text, newPassword: newPasswordConfirmField!.text, newPasswordConfirmed: newPasswordConfirmField!.text)
            }
        ))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        alert.addTextFieldWithConfigurationHandler{ (textField : UITextField!) -> Void in
            textField.placeholder = "Old Password"
            oldPasswordField = textField
        }
        alert.addTextFieldWithConfigurationHandler{ (textField : UITextField!) -> Void in
            textField.placeholder = "New Password"
            textField.layoutMargins.top = 8;
            newPasswordField = textField
        }
        alert.addTextFieldWithConfigurationHandler{ (textField : UITextField!) -> Void in
            textField.placeholder = "New Password (Confirm)"
            textField.layoutMargins.top = 8;
            newPasswordConfirmField = textField
        }
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        // 3rd party spinner library
        SVProgressHUD.show()
        
        newAccount = Account(username: self.account.username, birthYear: self.account.birthYear, height: self.account.height, weight: self.account.weight, sex: self.account.sex)
        
        if usernameField.text != nil && !usernameField.text!.isEmpty {
            newAccount!.username = usernameField.text!
        }
        
        if heightField.text != nil && !heightField.text!.isEmpty {
            newAccount!.height = Double(heightField.text!)
        }
        
        if weightField.text != nil && !heightField.text!.isEmpty {
            newAccount!.weight = Double(weightField.text!)
        }
        
        if birthYearField.text != nil && !birthYearField.text!.isEmpty {
            newAccount!.birthYear = Int(birthYearField.text!)
        }
        
        // Sex.all is {Male, Female} but segmented control is {N/A, Male, Female}.
        // We subtract 1 from the selected segment index to remove the 'N/A' option.
        newAccount!.sex = Sex.all[sexSegmentedControl.selectedSegmentIndex - 1]
        
        WebStore.editAccount(account, password: newPassword,
            errorCallback: { error in
                dispatch_async(dispatch_get_main_queue(),{
                    self.onEditAccountFailure(error)
                })
            }, successCallback: {
                dispatch_async(dispatch_get_main_queue(),{
                    self.onEditAccountSuccess()
                })
            }
        )
    }

    @IBAction func didBeginEditingDateTextField(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AccountDetailsViewController.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        account = appDelegate.account!
        
        birthYearField.text = (account.birthYear != nil) ? String(account.birthYear!) : ""
        
        // Sex.all is {Male, Female} but segmented control is {N/A, Male, Female}.
        // We add 1 to the Sex.all index to account for the 'N/A' in the segmented control.
        sexSegmentedControl.selectedSegmentIndex = (account.sex != nil) ? Sex.all.indexOf(account.sex!)! + 1 : 0
        heightField.text = (account.height != nil) ? String(account.height!) : ""
        weightField.text = (account.weight != nil) ? String(account.weight!) : ""
        usernameField.text = account.username
    }
    
    func onEditAccountSuccess() {
        SVProgressHUD.dismiss()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.account = newAccount!
        ViewControllerUtilities.transitionDrawered(self, destination: ViewIdentifier.RecordActivityNavController)

    }
    
    func onEditAccountFailure(error: WebStoreError) {
        
    }
    
    func passwordOkButtonPressed(oldPassword: String?, newPassword: String?, newPasswordConfirmed: String?) {
        let alert = UIAlertController(title: "Change Password", message: "Success!", preferredStyle: UIAlertControllerStyle.Alert)
        if (oldPassword != nil && newPassword != nil && newPasswordConfirmed != nil) && (!oldPassword!.isEmpty && !newPassword!.isEmpty && !newPasswordConfirmed!.isEmpty) {
            
            if newPassword != newPasswordConfirmed {
                alert.message = "New password and confirmation password must match."
            } else {
                self.newPassword = newPassword
            }
            
        } else {
            alert.message = "Please fill in all of the appropriate fields to change your password."
        }
        
        self.presentViewController(alert, animated: false, completion: nil)
    }

    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        birthYearField.text = dateFormatter.stringFromDate(sender.date)
    }
}
