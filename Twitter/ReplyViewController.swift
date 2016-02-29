//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Grace Egbo on 2/28/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController
{
    
    
    @IBOutlet weak var textBox: UITextView!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textBox.text = "@ \(tweet.name)"
        textBox.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Has been dismissed")
        }
    }

    @IBAction func onReply(sender: AnyObject) {
//        TwitterClient.sharedInstance.status(textBox.text, replyId: tweet.id, params:  nil) { (error) -> () in
//            print("Successfully did a reply")
//        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Has been dismissed")
        }
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
