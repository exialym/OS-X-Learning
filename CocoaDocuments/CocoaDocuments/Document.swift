//
//  Document.swift
//  CocoaDocuments
//
//  Created by 🦁️ on 15/11/12.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    var checked: Bool = true
    var textField: NSTextField!
    var text = ""
    var myViewController:ViewController!
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
        //在这里想要获得windowController的ViewController的textView尝试了很多办法。。。。
        //不知道为啥用下面这句话获取myViewController中的textView不成功
        //let myViewController = storyboard.instantiateControllerWithIdentifier("Document View Controller") as! ViewController
        //print(myViewController.textView)
        myViewController = (windowController.contentViewController) as! ViewController
        textField = myViewController.textView
        self.textField.stringValue = self.text
        myViewController.checkBox.integerValue = Int(self.checked)
    }

    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        self.text = self.textField.stringValue
        self.checked = Bool(self.myViewController.checkBox.integerValue)
        let dataDic = ["checked":self.checked,"text":self.text]
        //这个方法可以将一些特定的数据类型转换为JSON格式
        let serializedData = try? NSJSONSerialization.dataWithJSONObject(dataDic, options: NSJSONWritingOptions.PrettyPrinted)
        return serializedData!
        
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        //return self.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        let dataFromJSON = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary
        if dataFromJSON != nil {
            if let text = dataFromJSON!!["text"] as? String {
                self.text = text
            }
            if let checked = dataFromJSON!!["checked"] as? Bool {
                self.checked = checked
            }
        }
//        if data.length > 0{
//            let string = NSString(data: data, encoding: NSUTF8StringEncoding)
//            self.text = string as! String
//        } else {
//            self.text = ""
//        }
    }


}

