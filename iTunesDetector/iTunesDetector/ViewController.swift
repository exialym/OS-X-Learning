//
//  ViewController.swift
//  iTunesDetector
//
//  Created by 🦁️ on 15/11/18.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSNetServiceBrowserDelegate, NSNetServiceDelegate {

    let browser = NSNetServiceBrowser()
    var services = [NSNetService]()
    override func viewDidLoad() {
        super.viewDidLoad()
        browser.delegate = self
        browser.searchForServicesOfType("_daap._tcp", inDomain: "")
    }
    //发现服务
    func netServiceBrowser(browser: NSNetServiceBrowser, didFindService service: NSNetService, moreComing: Bool) {
        services.append(service)
        print("Found a Service: \(service)")
        service.delegate = self
        service.resolveWithTimeout(5.0)
    }
    //服务跑了
    func netServiceBrowser(browser: NSNetServiceBrowser, didRemoveService service: NSNetService, moreComing: Bool) {
        //这是一个从数组里去除特定元素的好办法
        services = services.filter(){$0 != service}
        print("A Service was removed:\(service)")
        
    }
    //成功解析服务地址
    func netServiceDidResolveAddress(sender: NSNetService) {
        print(sender)
        let serviceURL = NSURL(string: "http://\(sender.hostName):\(sender.port)")
        print("Resolved address for service \(sender):\(serviceURL)")
    }
    //解析失败
    func netService(sender: NSNetService, didNotResolve errorDict: [String : NSNumber]) {
        print("Couldn't resolved address for service \(sender),\(errorDict)")
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

