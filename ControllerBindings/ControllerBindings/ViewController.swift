//
//  ViewController.swift
//  ControllerBindings
//
//  Created by 🦁️ on 15/11/9.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var notes = [Note]()
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

