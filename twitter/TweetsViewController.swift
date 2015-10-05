//
//  TweetsViewController.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/4/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = User.currentUser?.name
        
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
      
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets?[indexPath.row]
        
        return cell
    }
    
    func refresh() {
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil) { (tweets, error) -> () in
            self.refreshControl.endRefreshing()
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
            let vc = segue.destinationViewController as! DetailsViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            vc.tmpTweet = tweets![(indexPath?.row)!]
        } else if segue.identifier == "replySegue" {
//            let vc = segue.destinationViewController as! ComposeViewController
//            let indexPath = tableView.indexPathForCell(sender as! UIButton)
//            vc.replyToTweet = tweets![(indexPath?.row)!]
            // todo: find the right Tweet to pass
        }
        
    }

}
