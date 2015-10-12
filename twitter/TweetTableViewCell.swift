//
//  TweetTableViewCell.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/4/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var message: UILabel!
    
    weak var navigationDelegate: AnyObject?
    
    var tweet: Tweet! {
        didSet {
            userName.text = tweet.user?.name
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            timestamp.text = dateFormatter.stringFromDate(tweet.createdAt!)
            message.text = tweet.text
            if tweet.user?.profileImageUrl != nil {
                userPicture.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
            }
            
            let tap = UITapGestureRecognizer(target: self, action: "userPictureTapped")
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1
            userPicture.addGestureRecognizer(tap)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userPictureTapped() {
        print("tapped")
//        let menu = self.navigationDelegate as! MenuViewController
//        menu.navigateToProfile(tweet.user!)
        let menu = (HamburgerViewController.globalNavigationController!.menuViewController as! MenuViewController)
        menu.navigateToProfile(tweet.user!)
    }
    
    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(self.tweet.tweetId!) { (tweet, error) -> () in
            print("success")
        }
    }
    
    @IBAction func favorite(sender: AnyObject) {
        //        let params = ["id": tweet.tweetId] as NSDictionary
        var params = [String: Int]()
        params["id"] = tweet.tweetId
        TwitterClient.sharedInstance.favorite(params) { (tweet, error) -> () in
            print("done")
        }
    }
    

}
