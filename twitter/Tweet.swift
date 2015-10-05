//
//  Tweet.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/3/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var tweetId: Int?
    var inReplyToStatusId: Int?
    var inReplyToStatusIdStr: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetId = dictionary["id"] as? Int
        inReplyToStatusId = dictionary["in_reply_to_status_id"] as? Int
        inReplyToStatusIdStr = dictionary["in_reply_to_user_id_str"] as? String

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()

        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
