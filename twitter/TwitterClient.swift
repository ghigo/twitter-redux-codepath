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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    // Home timeline
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            // print("home timeline: \(response)")
            let tweets = Tweet.tweetWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAt)")
            }
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error getting the home timeline")
            completion(tweets: nil, error: error)
        })
        
    }
    
    // Login
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Error getting the request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    // Verify credentials
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name!)")
                self.loginCompletion?(user: user, error: nil) 
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("error getting current user: \(error)")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    // Status update
    func statusUpdate(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        if params?["status"] != nil {
            POST("1.1/statuses/update.json", parameters: params, constructingBodyWithBlock: nil, success: { (request: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                print("Status update succeeded: \(response)")
                let tweet = Tweet.init(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            }) { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Status update failed: \(error)")
                completion(tweet: nil, error: error)
            }
        } else {
            // Return error
        }
    }
    
    // Retweet
    func retweet(id: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, constructingBodyWithBlock: nil, success: { (request: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("Retweet succeeded")
            let tweet = Tweet.init(dictionary: response as! NSDictionary)
            completion(tweet: tweet, error: nil)
            }) { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Retweet failed")
                completion(tweet: nil, error: error)
        }
    }
    
    // Favorite
    func favorite(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json", parameters: params, constructingBodyWithBlock: nil, success: { (request: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("Favorite succeeded")
            let tweet = Tweet.init(dictionary: response as! NSDictionary)
            completion(tweet: tweet, error: nil)
            }) { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Favorite failed")
                completion(tweet: nil, error: error)
        }
    }
}
