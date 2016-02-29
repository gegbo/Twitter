//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Grace Egbo on 2/28/16.
//  Copyright © 2016 Grace Egbo. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var textBox: UITextView!
    

    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textBox.text = ""
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

    
    @IBAction func onTweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.status(textBox.text, replyId: 0, params:  nil) { (error) -> () in
        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Has been dismissed")
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("RefreshTable", object: nil)

    }


    @IBAction func onTap(sender: AnyObject) {
        textBox.resignFirstResponder()
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
