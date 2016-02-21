//
//  TweetCell.swift
//  Twitter
//
//  Created by Grace Egbo on 2/21/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweetID: String = ""
    
    var tweet: Tweet! {
        didSet {
            tweetID = "\(tweet.id)"
            profilePictureImage.setImageWithURL(tweet.profileImageUrl!)
            print(profilePictureImage)
            name.text = tweet.name
            tagName.text = "@\(tweet.username!)"
            time.text = calculateTimeStamp((tweet.timestamp?.timeIntervalSinceNow)!)
            textContentLabel.text = tweet.text
            retweetCount.text = "\(tweet.retweetCount)"
            likeCount.text = "\(tweet.favoritesCount)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePictureImage.layer.cornerRadius = 3
        profilePictureImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //make a clickable button for retweet/favorite
    
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""

        rawTime = rawTime * (-1)

        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"

    }

}
