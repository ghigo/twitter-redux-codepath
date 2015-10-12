//
//  MenuViewController.swift
//  hamburger
//
//  Created by Marco Sgrignuoli on 10/11/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsNavigationController: UIViewController!
    private var profileNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    let titles = ["Timeline", "Profile"]
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewAndNavigationController")
        viewControllers.append(tweetsNavigationController)
        profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("ProfileNavigationController")
        viewControllers.append(profileNavigationController)
        
        
//        hamburgerViewController.contentViewController = firstNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.menuTitleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
    
//    @IBAction func showFirstView(sender: AnyObject) {
//        hamburgerViewController.contentViewController = viewControllers[0]
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
