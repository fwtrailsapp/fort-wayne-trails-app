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
        
        if usernameField.text != nil && passwordField.text != nil {
            if !usernameField.text!.isEmpty && !passwordField.text!.isEmpty {
                let username = usernameField.text!
                let password = passwordField.text!
                
                // log in
            }
        }
        
        ViewControllerUtilities.transitionDrawered(self, destination: ViewIdentifier.RecordActivityNavController)
    }
}
