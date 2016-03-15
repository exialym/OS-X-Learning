//
//  Note.swift
//  ControllerBindings
//
//  Created by 🦁️ on 15/11/9.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class Note: NSObject {
    let created: NSDate = NSDate()
    var edited: NSDate = NSDate()
    var title: String = "New Note" {
        didSet{
            edited = NSDate()
        }
    }
    var text:NSAttributedString = NSAttributedString(string: "New Note"){
        didSet{
            edited = NSDate()
        }
    }
}
