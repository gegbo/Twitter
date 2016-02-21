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
    var retweetCount: Int
    var favoritesCount: Int
    var id: Int
    
    init(dictionary: NSDictionary)
    {
     
        id = dictionary["id"] as! Int
        
        favoritesCount = (dictionary["favorite_count"] as? Int)!
        
        retweetCount = (dictionary["retweet_count"] as? Int)!
        
        name = dictionary["user"]!["name"] as? String
        
        username = dictionary["user"]!["screen_name"] as? String
        
        let profileImageString = dictionary["user"]!["profile_image_url_https"] as? String
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
            //var createdAt = NSDate()
            //createdAt =
            timestamp = formatter.dateFromString(timestampString)!
            //formatter.stringFromDate(createdAt)
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
