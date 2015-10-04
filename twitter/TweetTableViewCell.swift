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

}
