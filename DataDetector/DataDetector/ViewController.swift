//
//  ViewController.swift
//  DataDetector
//
//  Created by 🦁️ on 15/12/13.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var inoutText: NSTextView!
    @IBAction func check(sender: NSButton) {
        let detector = try? NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingAllTypes))
        let inputText = inoutText.string
        var resultString = ""
        if let matches = detector?.matchesInString(inputText!, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, (inputText! as NSString).length)) {
            for match in matches {
                let result = match
                switch result.resultType {
                case NSTextCheckingType.Link:
                    resultString += "Link: \(result.URL)\n"
                case NSTextCheckingType.Date:
                    resultString += "Date: \(result.date)\n"
                case NSTextCheckingType.PhoneNumber:
                    resultString += "Date: \(result.phoneNumber)\n"
                case NSTextCheckingType.Address:
                    resultString += "Date: \(result.addressComponents)\n"
                default:
                    resultString += "Other: \(result.description)\n"
                }
            }
        }
        print(resultString)
        outputText.stringValue = resultString
    }
    @IBOutlet weak var outputText: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

