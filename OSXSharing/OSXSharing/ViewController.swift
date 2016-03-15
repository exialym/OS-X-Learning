//
//  ViewController.swift
//  OSXSharing
//
//  Created by 🦁️ on 15/12/11.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var text: NSTextFieldCell!
    @IBAction func shareText(sender: NSButton) {
        var share = NSSharingServicePicker(items: [text.stringValue])
        share.showRelativeToRect(NSRect(x: 0.0, y: 0.0, width: 20, height: 30), ofView: self.view, preferredEdge: NSRectEdge.MaxY)
    }
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

