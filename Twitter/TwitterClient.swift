//
//  TwitterClient.swift
//  Twitter
//
//  Created by Grace Egbo on 2/21/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
        
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey:
        "G83a04MSb1Wn6DE99jEMcD9fL", consumerSecret: "9UREyAjo4OViMXHD6ahWRDu4vrnYTh1e2iULH5k0LsbDVWjlch")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ())
    {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token!")
            
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginFailure?(error)
        }

    }
    
    func logout()
    {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL)
    {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Received access token!")
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginFailure?(error)
        }

    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("/1.1/statuses/home_timeline.json", parameters: nil , progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
        
            success(tweets)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error) 
        }

    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ())
    {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error getting user")
            failure(error)
        })

    }
    
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () )
    {
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Retweeted tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't retweet")
                completion(error: error)
            }
        )
    }
    
    func favorite(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () )
    {
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Liked tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't like tweet")
                completion(error: error)
            }
        )
    }
    
    
    func status(text: String, replyId: Int, params: NSDictionary?, completion: (error: NSError?) -> ())
    {
        var parameters: [String : AnyObject] = ["status": text]

        //in case im replying to a tweet
        //have to work on it still!
        if replyId != 0
        {
            parameters["in_reply_to_status_id"] = replyId
        }

        
        POST("https://api.twitter.com/1.1/statuses/update.json", parameters: parameters, success: { (task: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("sucessfully did an update")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print("Did not do an update")
            completion(error: error)
        }
    }
    
}
