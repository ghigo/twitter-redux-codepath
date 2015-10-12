//
//  ProfileViewController.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/11/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User! {
        didSet {
            headerImage.setImageWithURL(NSURL(string: (user?.profileBannerUrl)!))
            if (user != nil) {
                tweetsCountLabel.text = "\(user!.tweets!) Tweets"
                followingCountLabel.text = "\(user!.following!) Following"
                FollowersCountLabel.text = "\(user!.followers!) Followers"
                self.title = user!.name!
            }
        }
    }
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var FollowersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
