//
//  ViewController.swift
//  myFirstOSXApp
//
//  Created by exialym on 15/10/21.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa
import QuartzCore
class ViewController: NSViewController {


    @IBOutlet var textView: NSTextView!
    
    @IBAction func changeBackgroundColor(sender: NSButtonCell) {
        colorAnim.fromValue = NSColor.whiteColor().CGColor
        colorAnim.toValue = NSColor.greenColor().CGColor
        colorAnim.duration = 1.5
        textView.layer?.addAnimation(colorAnim, forKey: "Background")
        textView.layer?.backgroundColor = NSColor.greenColor().CGColor
    }
    var colorAnim = CABasicAnimation(keyPath: "Background")
    override func viewDidLoad() {
        super.viewDidLoad()
        //这句话会返回一个someFile.txt的绝对路径，字符串
        let resourcePath = NSBundle.mainBundle().pathForResource("someFile", ofType: "txt")
        //这句话会返回一个someFile.txt的绝对路径，NSURL
        let resourceURL = NSBundle.mainBundle().URLForResource("someFile", withExtension: "txt")
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

