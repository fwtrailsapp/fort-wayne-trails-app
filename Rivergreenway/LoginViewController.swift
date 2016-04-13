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
        SVProgressHUD.dismiss()
        ViewControllerUtilities.transitionDrawered(self, destination: ViewIdentifier.RecordActivityNavController)
    }
    
    func displayMissingCredentialsAlert() {
        let alert = UIAlertController(title: "Cannot Log In", message: "Please enter a username and password.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
}
