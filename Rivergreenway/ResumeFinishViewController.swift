//
//  ResumeFinishViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/17/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ResumeFinishViewController: BaseViewController {

    // MARK : - Properties
    
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    private var delegate: ResumeFinishDelegate?
    
    // MARK : - Actions
    
    @IBAction func resumeButtonPressed(sender: UIButton) {
        delegate!.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setDelegate(delegate: ResumeFinishDelegate) {
        self.delegate = delegate
    }
}

protocol ResumeFinishDelegate {
    func resume()
    func finish()
}