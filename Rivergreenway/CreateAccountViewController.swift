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
        
    }
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Discard Changes",
            message: "Are you sure you wish to discard these changes?",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var dateTextField: UITextField!
    
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
        
    @IBAction func didBeginEditingDateTextField(sender: UITextField) {
        let yearPickerView:UIPickerView = UIPickerView()
        yearPickerView.dataSource = self
        yearPickerView.delegate = self
        sender.inputView = yearPickerView
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
        dateTextField.text = years[row]
    }
    
    func discardHandler(action: UIAlertAction) {
        transition(ViewIdentifier.LOGIN_VIEW)
    }
}
