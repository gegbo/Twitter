//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Grace Egbo on 2/21/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set up the tableview
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            for tweet in tweets{
                //print(tweet.text!)
            }

            print(tweets)
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tweets != nil {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
    }
    
    @IBAction func pressRetweet(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        cell.retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: UIControlState.Normal)
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.retweet(path, params: nil) { (error) -> () in
            print("Retweeting")
            tweet.retweetCount = tweet.retweetCount + 1
            //cell.retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: UIControlState.Normal)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pressLike(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.favorite(path, params: nil) { (error) -> () in
                print("Retweeting")
                tweet.favoritesCount = tweet.favoritesCount + 1
                //cell.favoriteButton.setImage(UIImage(named: "like-action-on.png"), forState: UIControlState.Normal)
                self.tableView.reloadData()
            }
       }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
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
