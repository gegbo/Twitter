//
//  DetailTweetViewController.swift
//  Twitter
//
//  Created by Grace Egbo on 2/25/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        profileImageView.setImageWithURL(tweet.profileImageUrl!)
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        name.text = tweet.name
        username.text = "@ \(tweet.username!)"
        
        tweetContent.text = tweet.text
        
        timestamp.text = tweet.timestamp?.description //try to display more nicely 
        
        retweetCount.text = "\(tweet.retweetCount)"
        likeCount.text = "\(tweet.favoritesCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onRetweet(sender: AnyObject) {
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.retweet(path, params: nil) { (error) -> () in
            self.tweet.retweetCount = self.tweet.retweetCount + 1
            self.retweetCount.text = "\(self.tweet.retweetCount)"
        }

        
    }
    
    
    @IBAction func onLike(sender: AnyObject) {
        let path = tweet.id
        
        TwitterClient.sharedInstance.favorite(path, params: nil) { (error) -> () in
            self.tweet.favoritesCount = self.tweet.favoritesCount + 1
            self.likeCount.text = "\(self.tweet.favoritesCount)"
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let detailViewController = segue.destinationViewController as! ReplyViewController
        
        detailViewController.tweet = tweet
    }
    

}
