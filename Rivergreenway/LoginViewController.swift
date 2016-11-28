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
//  LoginViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/24/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - View Components
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        
        if (usernameField.text != nil && passwordField.text != nil) && (!usernameField.text!.isEmpty && !passwordField.text!.isEmpty) {
            let username = usernameField.text!
            let password = passwordField.text!
            
            // 3rd party spinner library
            SVProgressHUD.show()
            
            WebStore.login(username, password: password,
                           errorCallback: {error in
                            dispatch_async(dispatch_get_main_queue(),{
                                ViewControllerUtilities.genericErrorHandler(self, error: error)
                            })},
                           successCallback: {
                            dispatch_async(dispatch_get_main_queue(),{
                                self.onLoginSuccess()
                            })
                }
            )
        } else {
            displayMissingCredentialsAlert()
        }
    }
    
    func onLoginSuccess() {
        
        // if the login is successful, attempt to get the account information from
        // the server
        WebStore.getAccount( errorCallback: {error in
            dispatch_async(dispatch_get_main_queue(),{
                ViewControllerUtilities.genericErrorHandler(self, error: error)
            })},
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
    
    func displayMissingCredentialsAlert() {
        let alert = UIAlertController(title: "Cannot Log In", message: "Please enter a username and password.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
}