//
//  ViewController.swift
//  Event
//
//  Created by 🦁️ on 15/12/2.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa
import EventKit
class ViewController: NSViewController, NSDatePickerCellDelegate {
    lazy var store: EKEventStore = EKEventStore()
    

    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func getDate(sender: NSDatePicker) {
        date = sender.dateValue
        for event in events{
            print(event.title)
            event.title = "balalala"
            _ = try? store.saveEvent(event, span: EKSpan.ThisEvent, commit: true)
            tableView.reloadData()
        }
    }
    var date: NSDate = NSDate(){
        willSet{
            //将所提供的日期转换为当天的午夜，因为当用户选择一个日期时
            let dateComponents = NSCalendar.currentCalendar().components([.Day,.Month,.Year], fromDate: newValue)
            if let dateResult = NSCalendar.currentCalendar().dateFromComponents(dateComponents) {
                self.date = dateResult
                print(date)
            }
        }
    }
    //获得包涵事件的日历
    var calenders: [EKCalendar] {
        get {
            return self.store.calendarsForEntityType(EKEntityType.Event) as [EKCalendar]
        }
    }
    //获取特定时间段的事件
    var events: [EKEvent] {
        get {
            let endDate = date.dateByAddingTimeInterval(24 * 60 * 60)
            let predicate = self.store.predicateForEventsWithStartDate(self.date, endDate: endDate, calendars: self.calenders)
            return self.store.eventsMatchingPredicate(predicate)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
        self.store.requestAccessToEntityType(EKEntityType.Event) { (success:Bool, error:NSError?) -> Void in
            //布尔值代表是否成功获取权限，error会在不成功时返回原因
            print("Got permission = \(success);error = \(error)")
        }
    }
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.events.count
    }
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier((tableColumn?.identifier)!, owner: self) as! NSTableCellView
        let textField = cell.textField
        let event = self.events[row]
        textField?.stringValue = event.title
        return cell
    }
    

}

