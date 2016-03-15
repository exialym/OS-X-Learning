//
//  ViewController.swift
//  Networking
//
//  Created by 🦁️ on 15/11/18.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSURLSessionDelegate {

    @IBOutlet weak var imageView: NSImageView!
    let myQueue = NSOperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.imageView.bounds.size.width
        let height = self.imageView.bounds.size.height
        let urlString = "http://lorempixel.com/\(Int(width))/\(Int(height))/sports/"
//        let url = NSURL(string: urlString)
//        let relativeurl = NSURL(string: "\(Int(width))/\(Int(height))/sports/", relativeToURL: NSURL(string:"http://lorempixel.com/"))
//        relativeurl?.host//lorempixel.com/
//        var r = NSMutableURLRequest(URL: NSURL(string: "e")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 2.0)
//        r.HTTPMethod//HTTP请求方法
//        r.allHTTPHeaderFields//HTTP请求头部
//        r.HTTPBody//HTTP请求体
//        r.allowsCellularAccess
        if let url = NSURL(string: urlString) {
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: myQueue)
            let dataTask = session.dataTaskWithURL(url, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if data == nil {
                    self.imageView.image = nil
                } else {
                    if let image = NSImage(data: data!) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.imageView.image = image
                        })
                    }
                }
            })
            dataTask.resume()
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

