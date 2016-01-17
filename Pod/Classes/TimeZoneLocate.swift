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
* Support for Swift 2.1 syntax
* Support for Framework linking

*/
import Foundation
import CoreLocation

extension CLLocation {
    public var timeZone: NSTimeZone {
        return TimeZoneLocate.timeZoneWithLocation(self)
    }
}

public class TimeZoneLocate : NSObject {
    
    // MARK: Singleton
    public static let sharedInstance = TimeZoneLocate()
    public static let timeZonesDB = TimeZoneLocate.importDataBaseFromFile("timezones.json")
    
    /*
    Get timezone with lat/lon and country code
    */
    public class func timeZoneWithLocation(location:CLLocation) -> NSTimeZone {
        if let closestZoneInfo = closestZoneInfoWithLocation(location, source: TimeZoneLocate.timeZonesDB),
            timeZone = timeZoneWithDictionary(closestZoneInfo)
        {
            return timeZone
        } else {
            //We've found nothing. Let's use system.
            return NSTimeZone.systemTimeZone()
        }
        
    }
    
    /*
    Get timezone with lat/lon and country code.
    Extremely speeds up and more carefull result.
    */
    public class func timeZoneWithLocation(location:CLLocation, countryCode:String?) -> NSTimeZone? {
        
        //Need a countr
        if let countryCode = countryCode,
            //Filter
            filteredZones = filteredTimeZonesWithCountyCode(countryCode),
            //Get closest zone info
            closestZoneInfo = closestZoneInfoWithLocation(location, source:filteredZones),
            //get timzone
            timeZone = timeZoneWithDictionary(closestZoneInfo)
        {
            return timeZone
        } else {
            return timeZoneWithLocation(location)
        }
        
    }
    
    /*
    Import from DB
    */
    public class func importDataBaseFromFile(fileName:String) -> [[NSObject:AnyObject]] {
        let currentBundle = NSBundle(forClass: TimeZoneLocate.self)
        
        let filePath = currentBundle.pathForResource(fileName, ofType: nil, inDirectory: "TimeZoneLocate.bundle") ??  currentBundle.pathForResource(fileName, ofType: nil)
        do {
            if let filePath = filePath,
                jsonData = NSData(contentsOfFile: filePath),
                timeZones = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [[NSObject:AnyObject]]
            {
                return timeZones
            }
        } catch let error as NSError {
            NSLog("Invalid timezoneDB format %@", error.localizedDescription)
        }
        
        //let filePath = currentBundle.resourcePath
        assertionFailure("Error loading or parse timeZoneDB file: \(filePath)")
        return [[NSObject:AnyObject]]()
    }
    
    /*
    Calculates the closest distance from source
    */
    public class func closestZoneInfoWithLocation(location: CLLocation, source:[[NSObject:AnyObject]]?) -> [NSObject:AnyObject]? {
        
        var closestDistance: CLLocationDistance = Double.infinity
        var closestZoneInfo: [NSObject:AnyObject]?
        
        if let source = source {
            for locationInfo in source {
                
                if let latitude = locationInfo["latitude"] as? Double,
                    longitude = locationInfo["longitude"] as? Double {
                        
                        let distance = location.distanceFromLocation( CLLocation(latitude: latitude, longitude: longitude) )
                        if  distance < closestDistance {
                            closestDistance = distance
                            closestZoneInfo = locationInfo
                        }
                }
            }
        }
        
        return closestZoneInfo
    }
    
    /*
    Filtering the whole DB with the country code
    */
    public class func filteredTimeZonesWithCountyCode(countryCode: String) -> [[NSObject:AnyObject]]? {
        let predicate = NSPredicate(format: "country_code LIKE %@", countryCode)
        return (TimeZoneLocate.timeZonesDB as NSArray).filteredArrayUsingPredicate(predicate) as? [[NSObject:AnyObject]]
    }
    
    /*
    Timezone from dict
    */
    public class func timeZoneWithDictionary(zoneInfo: [NSObject:AnyObject]?) -> NSTimeZone? {
        
        if let zoneName = zoneInfo?["zone"] as? String {
            return NSTimeZone(name: zoneName)
        }
        return nil
    }
    
}

