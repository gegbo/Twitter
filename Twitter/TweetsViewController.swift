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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "RefreshTable", object: nil)
        
        //set up the tableview
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 120

        navigationItem.title = "Timeline"
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            for tweet in tweets{
                //print(tweet.text!)
            }
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadTableData(notification: NSNotification)
    {
        self.tableView.reloadData()
        print("I got here!")
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
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.retweet(path, params: nil) { (error) -> () in
            tweet.retweetCount = tweet.retweetCount + 1
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
                tweet.favoritesCount = tweet.favoritesCount + 1
                self.tableView.reloadData()
            }
       }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "profileView")
        {
            print("Going to profile page")
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPathForCell(cell)
            
            let user = tweets[indexPath!.row]
            
            let detailViewController = segue.destinationViewController as! ProfilePageViewController
            
            //create a user variale for tweets and then set user to tweets.user
            detailViewController.user = user
        }
        
        if(segue.identifier == "tweetDetail")
        {
            print("Going to tweet details")
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            
            let tweet = tweets[indexPath!.row]
            
            let detailViewController = segue.destinationViewController as! DetailTweetViewController
            
            detailViewController.tweet = tweet

        }
        
        if (segue.identifier == "composeSegue")
        {
            print("Going to compose page")
            
            let detailViewController = segue.destinationViewController as! ComposeViewController
            
            detailViewController.user = User._currentUser
            
        }

    }
    

}
