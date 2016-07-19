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
        dateLabel.text = Date().string(dateStyle: .long, timeStyle: .short)
    }
    
    @IBAction func didPressStyle(sender: AnyObject) {
        dateLabel.text = Date().string(dateStyle: .long, timeStyle: .short)
    }
    
    @IBAction func didPressTemplateFullShort(sender: AnyObject) {
        dateLabel.text = Date().string(with: .fullShortDate)
    }
    
    @IBAction func didPressTemplateMonthAndYear(sender: AnyObject) {
        dateLabel.text = Date().string(with: .monthAndYear)
    }
    
    @IBAction func didPressFormatFullDate(sender: AnyObject) {
        dateLabel.text = Date().string(with: .fullDate)
    }
    
    @IBAction func didPressFormatFullDateAndTime(sender: AnyObject) {
        dateLabel.text = Date().string(with: .fullDateAndTime)
    }
    
    @IBAction func didPressCustom(sender: AnyObject) {
        let myProvider = MyDateFormatterProvider(format: "MMMM yyyy")
        dateLabel.text = Date().string(with: myProvider)
    }
}

