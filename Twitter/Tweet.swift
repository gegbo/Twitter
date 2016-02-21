//
//  Tweet.swift
//  Twitter
//
//  Created by Grace Egbo on 2/20/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var name: String?
    var username: String?
    var profileImageUrl: NSURL?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary)
    {
        name = dictionary["name"] as? String
        
        username = dictionary["screen_name"] as? String
        
        let profileImageString = dictionary["profile_image_url_https"] as? String
        if let profileImageString = profileImageString
        {
            profileImageUrl = NSURL(string: profileImageString)
            
        }
       
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
