//
//  LocationFramework.swift
//  LocationFramework
//
//  Created by Summer on 17/05/2017.
//  Copyright © 2017 Summer. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

public class LocationFramework: NSObject, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    var lastLocationUpdate: NSDate?
    var locationInformations = [String]()
    var locations: [String]?
    public var updateLocation: (([String]) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self

    }
    
    public func setupLocationManager() {
        
        locationManager.distanceFilter = kCLHeadingFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func checkStatus() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted:
            print("restricted")
            cutoutLocation()
            showAlert()
            break
            
        case .denied:
            print("denied")
            cutoutLocation()
            showAlert()
            break
            
        case .notDetermined:
            print("notDetermined")
            
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .authorizedAlways:
            print("authorizedAlways")
            beginLocation()
            break
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            beginLocation()
            break
        default:
            break
        }
    }
    
    public func cutoutLocation() {
        
        print("terminate use")
        
    }
    
    public func beginLocation() {
        
        setupLocationManager()
        locationManager.startUpdatingLocation()

    }

    //MARK: Location delegate method
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status is \(status)");
        checkStatus()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0];
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        if lastLocationUpdate == nil {
            lastLocationUpdate = NSDate()
        }
        let locationString = String(format: "latitude is %f, longitude is %f, time is %@", latitude, longitude, lastLocationUpdate!)
        locationInformations.append(locationString)
        if let updateLocation = updateLocation {
            updateLocation(locationInformations)
        }
        lastLocationUpdate = NSDate()

    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("失败")
    }
    
    public func showAlert() {
        let url = NSURL.fileURL(withPath: UIApplicationOpenSettingsURLString, isDirectory: true)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        }
    }
}

