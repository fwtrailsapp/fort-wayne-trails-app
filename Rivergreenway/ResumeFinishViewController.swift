//
//  ResumeFinishViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/17/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
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
    
    @IBAction func finishButtonPressed(sender: UIButton) {
        delegate!.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDelegate(delegate: ResumeFinishDelegate) {
        self.delegate = delegate
    }
}

protocol ResumeFinishDelegate {
    func resume()
    func finish()
}
