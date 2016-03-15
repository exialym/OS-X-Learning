//
//  ViewController.swift
//  CocoaTableView
//
//  Created by 🦁️ on 15/11/10.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate{
    var songs: [Song] = []
    //这里将所有song加到了songsController里，songsController在storyBoard里又是和songs绑定的
    @IBOutlet weak var songsController: NSArrayController!
    
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.songs.count == 0 {
            var aSong: Song!
            aSong = Song()
            aSong.title = "Song1"
            aSong.duration = 100
            //虽然songs和songsController绑定，但是将song加到songs里貌似改变不了songsController。但是添加到songsController里可以同步到songs
            //self.songs.append(aSong)
            self.songsController.addObject(aSong)
            aSong = Song()
            aSong.title = "Song2"
            aSong.duration = 200
            //self.songs.append(aSong)
            self.songsController.addObject(aSong)
            aSong = Song()
            aSong.title = "Song3"
            aSong.duration = 3100
            //self.songs.append(aSong)
            self.songsController.addObject(aSong)
            aSong = Song()
            aSong.title = "Song4"
            aSong.duration = 400
            //self.songs.append(aSong)
            self.songsController.addObject(aSong)
//            songs.removeLast()直接修改数组是不行的
//            print(self.songs)
//            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.songs.count
    }
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier((tableColumn?.identifier)!, owner: self) as! NSTableCellView
        let textField = cell.textField
        let song = self.songs[row]
        if tableColumn?.identifier == "Title" {
            textField?.stringValue = song.title
        } else if tableColumn?.identifier == "Duration" {
            let durationText = NSString(format: "%i:%02i", Int(song.duration)/60,Int(song.duration)%60)
            textField?.stringValue = durationText as String
        }
        return cell
    }
    func tableView(tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        for sortDescriptor in tableView.sortDescriptors.reverse() as [NSSortDescriptor] {
            songs.sortInPlace(){ (item1, item2) -> Bool in
                return sortDescriptor.compareObject(item1, toObject: item2) == NSComparisonResult.OrderedAscending
            }
        }
        tableView.reloadData()
    }
}

