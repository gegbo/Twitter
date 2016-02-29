//
//  Tweet.swift
//  Twitter
//
//  Created by Grace Egbo on 2/20/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int
    var favoritesCount: Int
    var id: Int
    
    //following associated with the user
    var name: String?
    var username: String?
    var profileImageUrl: NSURL?
    var backgroundProfileImageUrl: NSURL?
    var numTweets: Int?
    var numFollowers: Int?
    var numFollowing: Int?
    
    init(dictionary: NSDictionary)
    {
        id = dictionary["id"] as! Int
        
        favoritesCount = (dictionary["favorite_count"] as? Int)!
        
        retweetCount = (dictionary["retweet_count"] as? Int)!
    
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
        
        //following all associated with the user of the tweet
        name = dictionary["user"]!["name"] as? String
        
        
        username = dictionary["user"]!["screen_name"] as? String
        
        let profileImageString = dictionary["user"]!["profile_image_url_https"] as? String
        if let profileImageString = profileImageString
        {
            profileImageUrl = NSURL(string: profileImageString)
            
        }
        
        let backgroundProfileImageString = dictionary["user"]!["profile_background_image_url_https"] as? String
        if let backgroundProfileImageString = backgroundProfileImageString
        {
            backgroundProfileImageUrl = NSURL(string: backgroundProfileImageString)
            
        }
        
        numTweets = dictionary["user"]!["statuses_count"] as? Int
        
        numFollowers = dictionary["user"]!["followers_count"] as? Int
        
        numFollowing = dictionary["user"]!["following"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
   }
