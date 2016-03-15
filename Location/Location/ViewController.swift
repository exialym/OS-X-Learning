//
//  ViewController.swift
//  Location
//
//  Created by 🦁️ on 15/11/22.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa
import CoreLocation

class ViewController: NSViewController, CLLocationManagerDelegate {

    @IBOutlet weak var longitudeLabel: NSTextField!
    @IBOutlet weak var latitudeLabel: NSTextField!
    @IBOutlet weak var accuracyLabel: NSTextField!
    @IBOutlet weak var spinner: NSProgressIndicator!
    @IBOutlet weak var addressLabel: NSTextField!
    //获取位置
    var locationManager = CLLocationManager()
    //获取地址编码
    var geocoder = CLGeocoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("q")
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.spinner.startAnimation(nil)
        //监测用户出入该区域
        let location = CLLocationCoordinate2DMake(39.96, 116.35)
        let region = CLCircularRegion(center: location, radius: 1000, identifier: "BUPT")
        locationManager.startMonitoringForRegion(region)
//下面这一段是用来告诉系统什么时候可以进入Nap什么时候不可以，不过貌似有点问，运行时会报错
//Failed to set (contentViewController) user defined inspected property on (NSWindow): Invalid class type

//        let queue = NSOperationQueue.mainQueue()
//        var token = NSProcessInfo.processInfo()
//        token.beginActivityWithOptions(NSActivityOptions.UserInitiated, reason: "Important stuff")
//        queue.addOperationWithBlock { () -> Void in
//            //做一些重要的事，在做这些事时App不会进入nap模式
//            print("a")
//        }
//        NSProcessInfo.processInfo().endActivity(token)
        
//        token = NSProcessInfo.processInfo()
//        token.beginActivityWithOptions(NSActivityOptions.Background, reason: "not important")
//        queue.addOperationWithBlock { () -> Void in
//            //这里做的事在app不可见时很可能被打断
//        }
//        NSProcessInfo.processInfo().endActivity(token)
    }
    //成功获得用户位置
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        if let newLocation = locations.last as? CLLocation {
            self.longitudeLabel.stringValue = NSString(format: "%.2f", newLocation.coordinate.longitude) as String
            self.latitudeLabel.stringValue = NSString(format: "%.2f", newLocation.coordinate.latitude) as String
            self.accuracyLabel.stringValue = NSString(format: "%.1fm", newLocation.horizontalAccuracy) as String
            self.spinner.hidden = true
            self.geocoder.reverseGeocodeLocation(newLocation)
            { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
                if error == nil {
                    //对于一个坐标，可能会返回多个地址
                    let placemark = placemarks![0] as CLPlacemark
                    let address = NSString(format: "%@ %@, %@, %@ %@",
                                           placemark.country!,
                                           placemark.administrativeArea!,
                                           placemark.locality!,
                                           placemark.thoroughfare!,
                                           placemark.subThoroughfare!)
                    self.addressLabel.stringValue = address as String
                } else {
                    self.addressLabel.stringValue = "Fail to Find an Address"
                }
            }
        } else {
            print("No location found")
        }
        
    }
    //获得用户位置失败
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.longitudeLabel.stringValue = "Not Found"
        self.latitudeLabel.stringValue = "Not Found"
        self.accuracyLabel.stringValue = "Not Found"
        self.spinner.hidden = true
    }
    //用户进入监测区域
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter \(region.identifier)")
    }
    //用户离开监测区域
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("leave \(region.identifier)")
    }
    

    


}

