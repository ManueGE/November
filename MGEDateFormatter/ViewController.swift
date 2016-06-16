//
//  ViewController.swift
//  MGEDateFormatter
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = NSDate().string(withDateStyle: .LongStyle, timeStyle: .ShortStyle)
        
    }
    
    @IBAction func didPressStyle(sender: AnyObject) {
        dateLabel.text = NSDate().string(withDateStyle: .LongStyle, timeStyle: .ShortStyle)
    }
    
    @IBAction func didPressTemplateFullShort(sender: AnyObject) {
        dateLabel.text = NSDate().string(with: .fullShortDate)
    }
    
    @IBAction func didPressTemplateMonthAndYear(sender: AnyObject) {
        dateLabel.text = NSDate().string(with: .monthAndYear)
    }
    
    @IBAction func didPressFormatFullDate(sender: AnyObject) {
        dateLabel.text = NSDate().string(with: .fullDate)
    }
    
    @IBAction func didPressFormatFullDateAndTime(sender: AnyObject) {
        dateLabel.text = NSDate().string(with: .fullDateAndTime)
    }
    
    @IBAction func didPressCustom(sender: AnyObject) {
        let myProvider = MyDateFormatterProvider(format: "MMMM yyyy")
        dateLabel.text = NSDate().string(with: myProvider)
    }
}

