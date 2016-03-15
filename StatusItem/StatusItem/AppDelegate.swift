//
//  AppDelegate.swift
//  StatusItem
//
//  Created by 🦁️ on 15/12/13.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var menu: NSMenu!
    @IBAction func Quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(nil)
    }
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        statusItem.title = "My Item"
        statusItem.menu = self.menu
        statusItem.highlightMode = true
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

