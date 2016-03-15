//
//  ViewController.swift
//  VideoPlayer
//
//  Created by 🦁️ on 15/11/2.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa
import AVFoundation
import QuartzCore
import AVKit
class ViewController: NSViewController ,NSFileManagerDelegate{

//    @IBOutlet weak var playerView: NSView!
//    
//    @IBAction func play(sender: NSButton) {
//        self.player?.play()
//    }
//    @IBAction func playSlow(sender: NSButton) {
//        self.player?.rate = 0.25
//    }
//    @IBAction func playBack(sender: NSButton) {
//        self.player?.seekToTime(kCMTimeZero)
//    }
//    var player: AVPlayer?
    @IBOutlet weak var playerView: AVPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let contentURL = NSBundle.mainBundle().URLForResource("TestVideo", withExtension: "m4v") {
//            player = AVPlayer(URL: contentURL)
//        }
//        let playerLayer = AVPlayerLayer(player: player)
//        self.playerView.layer?.addSublayer(playerLayer)
//        playerLayer.frame = self.playerView.bounds
//        playerLayer.autoresizingMask = CAAutoresizingMask.LayerWidthSizable //CAAutoresizingMask.LayerHeightSizable
//        self.player?.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        if let contentURL = NSBundle.mainBundle().URLForResource("TestVideo", withExtension: "m4v") {
            self.playerView.player = AVPlayer(URL: contentURL)
        }
        
        
        //这里获取的是共享的文件管理器对象
        var fileManager = NSFileManager.defaultManager()
        //如果你想对文件进行像复制或移动之类的操作时，在这样的操作完成时NSFilerManager会给其代理发送一个消息，这时就不能用共享对象了，而是要建立一个自己的对象
        fileManager = NSFileManager()
        //将自己设置为代理，当操作完成时获得提示
        fileManager.delegate = self
        let DesktopURL = "/Users/exialym/Desktop/"
        let folderURL = NSURL.fileURLWithPath(DesktopURL)
        //这个方法返回文件夹内所有文件的NSURL
        let folderContents = try? fileManager.contentsOfDirectoryAtURL(folderURL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
        //如果你要获取大量文件的属性，你可以在contentOfDirectoryAtURL的includingPropertiesForKeys参数里传入要查的属性的键
        if (folderContents != nil) {
            for file in folderContents! {
                //要获取的属性的值
                let attr = [NSURLFileSizeKey,NSURLContentModificationDateKey]
                //NSURL有这么个获取各种属性的方法
                let attrDic = try? file.resourceValuesForKeys(attr)
                if (attrDic != nil) {
                    let fileSize = (attrDic![NSURLFileSizeKey]) as? NSNumber
                    let fileLastDate = attrDic![NSURLContentModificationDateKey] as? NSDate
                    print("\(file):\(fileSize)+\(fileLastDate)")
                }
            }
        }
        
        //如果你要临时储存什么文件可以申请一个临时目录，这个目录在系统认为磁盘空间不够时会被自动清除，所以要小心
        let temporaryDirectoryPath = NSTemporaryDirectory()
        let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectoryPath)
        //这里返回给你的是一个可以在其中储存文件的临时目录，最好在里面新建个文件夹再存东西
        print(temporaryDirectoryURL)
        
        //创建新目录
        let newDirectoryURL = NSURL.fileURLWithPath(DesktopURL + "/newFile/a/b")
        //withIntermediateDirectories为true时就可以创建新文件夹和它的子文件夹
        let didCreate = try? fileManager.createDirectoryAtURL(newDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        didCreate != nil ? print("Dir:success") : print("Dir:failed")
        //创建文件，路径里记得包含文件名
        let myData = NSData(contentsOfURL: NSURL(string: "http://www.feng.com/favicon.ico")!)
        fileManager.createFileAtPath(DesktopURL + "/newFile/a/aa", contents: myData, attributes: nil)
        //复制
        let dara = try? fileManager.copyItemAtPath(DesktopURL + "/newFile/a/aa", toPath: DesktopURL + "/newFile/a/b/aa")
        //移动
        _ = try? fileManager.moveItemAtPath(DesktopURL + "/newFile/a/b/aa", toPath: DesktopURL + "/newFile/aa")
        //删除文件，直接删除，不是放入废纸篓
        _ = try? fileManager.removeItemAtPath(DesktopURL + "/newFile/a/aa")
        
        //有一些常用目录用来存储文件，比如文档，桌面等，我们可以通过这个方法来获取这些文件夹的路径这个方法返回一个URL的数组
        //比如你想获取桌面的路径，这样获取路径在开启和不开启沙盒的情况下是不同的
        //不开启时你获取到的是正常的：file:///Users/exialym/Desktop/
        //开启时获取的就是：file:///Users/exialym/Library/Containers/edu.bupt.exialym.VideoPlayer/Data/Desktop/
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DesktopDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        print(urls)
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.beginWithCompletionHandler { (result:Int) -> Void in
            self.playerView.player = AVPlayer(URL: panel.URL!)
        }
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

