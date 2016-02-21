//
//  Tweet.swift
//  Twitter
//
//  Created by Grace Egbo on 2/20/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary)
    {
        text = dictionary["text"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString
        {
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
   }
