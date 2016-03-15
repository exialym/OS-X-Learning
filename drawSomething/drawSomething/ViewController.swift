//
//  ViewController.swift
//  drawSomething
//
//  Created by exialym on 15/10/26.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var myView: NSView!{
        didSet{
            myView.setNeedsDisplayInRect(myView.bounds)
        }
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

