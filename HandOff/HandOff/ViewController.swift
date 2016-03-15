//
//  ViewController.swift
//  HandOff
//
//  Created by 🦁️ on 15/11/26.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSUserActivityDelegate{

    @IBOutlet weak var switch1: NSButton!
    @IBOutlet weak var switch2: NSButton!
    @IBOutlet weak var switch3: NSButton!
    @IBAction func switch1Change(sender: NSButton) {
        self.activity?.needsSave = true
    }
    @IBAction func switch2Change(sender: NSButton) {
        self.activity?.needsSave = true
    }
    @IBAction func switch3Change(sender: NSButton) {
        self.activity?.needsSave = true
    }
    func userActivityWillSave(userActivity: NSUserActivity) {
        userActivity.userInfo = activityInfoDictionary()
    }
    var activity: NSUserActivity?
    func activityInfoDictionary() -> [String:Bool] {
        return[
            "switch1":switch1.intValue == 0 ? false : true,
            "switch2":switch2.intValue == 0 ? false : true,
            "switch3":switch3.intValue == 0 ? false : true,
        ]
    }
    override func viewWillAppear() {
        activity = NSUserActivity(activityType: "com.exialym.BUPT.Handoff.switchs")
        activity?.userInfo = activityInfoDictionary()
        activity?.title = "Switches"
        activity?.delegate = self
        activity?.becomeCurrent()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear() {
        activity?.invalidate()
        activity = nil
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

