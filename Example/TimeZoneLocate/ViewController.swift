//
//  ViewController.swift
//  TimeZoneLocate
//
//  Created by apersaud on 07/27/2019.
//  Copyright (c) 2019 apersaud. All rights reserved.
//

import UIKit
import CoreLocation
import TimeZoneLocate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Override point for customization after application launch.
        let location = CLLocation(latitude: 32.88, longitude: -117.15)
        //helper method
        let theTimeZone = location.timeZone
        print("TimeZone: \(theTimeZone.identifier)")
        // Or the shared method
        let timeZone = TimeZoneLocate.timeZoneWithLocation(location)
        print(timeZone)
        if let timeZone = TimeZoneLocate.timeZone(location: location, countryCode: nil) {
            print(timeZone)
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("San Diego, CA") { (placemarks, error) -> Void in
            if error == nil, let placemarks = placemarks, let placemark = placemarks.first {
                
                let locationTimeZone = placemark.location?.timeZone
                print(locationTimeZone!)
                //of if country code is known, then
                if let location = placemark.location, let countryCode = placemark.addressDictionary?["CountryCode"] as? String {
                    let fastTimeZone = TimeZoneLocate.timeZone(location: location, countryCode: countryCode)
                    print(fastTimeZone!)
                }
                
                //Helper method
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

