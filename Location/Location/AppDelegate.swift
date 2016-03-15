//
//  AppDelegate.swift
//  Location
//
//  Created by 🦁️ on 15/11/22.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidChangeOcclusionState(notification: NSNotification) {
        if NSApp.occlusionState.rawValue == 8194 {
            print("foreground")
        } else {
            print("background")
        }
    }
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

