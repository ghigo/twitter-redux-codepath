//
//  TwitterClient.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/3/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

let twitterConsumerKey = "JCV79PHWLF4Hhj2dtdRvwGDB6"
let twitterConsumerSecret = "WYdqs8Ussrl235iWlDNgoy8vWKOejGqEMAEreWLr9neyPpUOr3"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
