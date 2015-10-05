//
//  ComposeViewController.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/4/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

let tweetPostedNotification = "tweetPosted"

class ComposeViewController: UIViewController {
    
    var replyToTweet: Tweet?
    
    @IBOutlet weak var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
        if replyToTweet != nil {
            let screenname = replyToTweet?.user?.screenname as String!
            messageTextView.text = "@\(screenname) "
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewTweet(sender: AnyObject) {
        let message = messageTextView.text
        if message != nil {
            var params = ["status": message]
            if self.replyToTweet != nil {
                params["in_reply_to_status_id"] = "\(self.replyToTweet?.tweetId)"
            }
            TwitterClient.sharedInstance.statusUpdate(params) { (tweet, error) -> () in
                if tweet != nil {
                    print("Message posted successfully: \(tweet)")
                    //                self.tweets?.insert(tweet!, atIndex: 0)
                    //                self.tableView.reloadData()
                    // Notify main controller and prepend the new item, then reload data
                    self.navigationController?.popToRootViewControllerAnimated(true)
                } else if error != nil {
                    print("Message failed: \(error)")
                }
            }
        } else {
            // No message
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
