//
//  TimeZoneLocate.swift
//
//  Created by Sergii Kryvoblotskyi on 10/17/13.
//  Copyright (c) 2013 Alterplay. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/*
Original Source https://github.com/Alterplay/APTimeZones
by Sergii Kryvoblotskyi on 10/17/13.
Copyright (c) 2013 Alterplay. All rights reserved.

Project Name was changed to prevent pod conflict.
Swift Conversion by Modernistik LLC.

This version featured:
* Support for Swift 3.0 syntax
* Support for Framework linking

*/
import Foundation
import CoreLocation

extension CLLocation {
    public var timeZone: TimeZone {
        return TimeZoneLocate.timeZoneWithLocation(self)
    }
}

open class TimeZoneLocate : NSObject {
    
    // MARK: Singleton
    open static let sharedInstance = TimeZoneLocate()
    open static let timeZonesDB = TimeZoneLocate.importDataBaseFromFile("timezones.json")
    
    /*
    Get timezone with lat/lon and country code
    */
    open class func timeZoneWithLocation(_ location:CLLocation) -> TimeZone {
        guard let closestZoneInfo = closestZoneInfo(location:location, source: TimeZoneLocate.timeZonesDB),
              let timeZone = timeZoneWithDictionary(closestZoneInfo)
            else { return TimeZone.current } //We've found nothing. Let's use system.
        return timeZone
    }
    
    /*
    Get timezone with lat/lon and country code.
    Extremely speeds up and more carefull result.
    */
    open class func timeZone(location:CLLocation, countryCode:String? = nil) -> TimeZone? {
        
        //Need a countr
        guard let countryCode = countryCode,
            //Filter
            let filteredZones = filteredTimeZones(countryCode:countryCode),
            //Get closest zone info
            let closestZoneInfo = closestZoneInfo(location:location, source:filteredZones),
            //get timzone
            let timeZone = timeZoneWithDictionary(closestZoneInfo)
        else { return self.timeZone(location: location)}
        
        return timeZone
    }
    
    /*
    Import from DB
    */
    open class func importDataBaseFromFile(_ fileName:String) -> [[AnyHashable: Any]] {
        let currentBundle = Bundle(for: TimeZoneLocate.self)
        
        let filePath = currentBundle.path(forResource: fileName, ofType: nil, inDirectory: "TimeZoneLocate.bundle") ??  currentBundle.path(forResource: fileName, ofType: nil)
        do {
            if let filePath = filePath,
                let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
                let timeZones = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[AnyHashable: Any]]
            {
                return timeZones
            }
        } catch let error as NSError {
            NSLog("Invalid timezoneDB format %@", error.localizedDescription)
        }
        
        //let filePath = currentBundle.resourcePath
        assertionFailure("Error loading or parse timeZoneDB file: \(filePath)")
        return [[AnyHashable: Any]]()
    }
    
    /*
    Calculates the closest distance from source
    */
    open class func closestZoneInfo(location: CLLocation, source:[[AnyHashable: Any]]?) -> [AnyHashable: Any]? {
        
        var closestDistance: CLLocationDistance = Double.infinity
        var closestZoneInfo: [AnyHashable: Any]?
        
        guard let source = source else { return nil }
            
        for locationInfo in source {
            guard let latitude = locationInfo["latitude"] as? Double,
                  let longitude = locationInfo["longitude"] as? Double else { continue }
            
            let distance = location.distance( from: CLLocation(latitude: latitude, longitude: longitude) )
            if  distance < closestDistance {
                closestDistance = distance
                closestZoneInfo = locationInfo
            }
        }
        
        return closestZoneInfo
    }
    
    /*
    Filtering the whole DB with the country code
    */
    open class func filteredTimeZones(countryCode: String) -> [[AnyHashable: Any]]? {
        let predicate = NSPredicate(format: "country_code LIKE %@", countryCode)
        return (TimeZoneLocate.timeZonesDB as NSArray).filtered(using: predicate) as? [[AnyHashable: Any]]
    }
    
    /*
    Timezone from dict
    */
    open class func timeZoneWithDictionary(_ zoneInfo: [AnyHashable: Any]?) -> TimeZone? {
        guard let zoneName = zoneInfo?["zone"] as? String else { return nil }
        
        return TimeZone(identifier: zoneName)
    }
    
}

