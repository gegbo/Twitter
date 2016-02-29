//
//  ProfilePageViewController.swift
//  Twitter
//
//  Created by Grace Egbo on 2/25/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    

    var user: Tweet!    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backgroundImageView.setImageWithURL(user.backgroundProfileImageUrl!)
        
        mainImageView.setImageWithURL(user.profileImageUrl!)
        mainImageView.layer.cornerRadius = 3
        mainImageView.clipsToBounds = true
        
        name.text = user.name
        
        username.text = "@ \(user.username!)"
        
        tweetCount.text = "\(user.numTweets!)"
        
        followingCount.text = "\(user.numFollowing!)"
        
        followersCount.text = "\(user.numFollowers!)"


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
