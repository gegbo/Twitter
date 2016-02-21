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
    
    var tweet: Tweet! {
        didSet {
            //profilePictureImage.setImageWithURL(tweet.profileImageUrl!)
            name.text = tweet.name
            tagName.text = tweet.username
            time.text = tweet.timestamp?.description
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
    

}
