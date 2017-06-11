//
//  LocationFramework.swift
//  LocationFramework
//
//  Created by liuhaoyang on 2017/5/16.
//  Copyright © 2017年 liuhaoyang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

public class LocationFramework: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func checkStatus() {
        let status = CLLocationManager.authorizationStatus()
        NSLog("status: \(status.rawValue)")
        switch status {
        case .restricted:
            cutoutLocation()
            break
            
        case .denied:
            cutoutLocation()
            break
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .authorizedAlways:
            beginLocation()
            break
            
        case .authorizedWhenInUse:
            beginLocation()
            break
        }
    }
    
    public func cutoutLocation() {
        
        print("terminate use")
    
    }
    
    public func beginLocation() {
        
    }

//-  MARK: Location delegate method
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        NSLog("Here")
    }
    
}

