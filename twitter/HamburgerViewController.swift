//
//  ViewController.swift
//  hamburger
//
//  Created by Marco Sgrignuoli on 10/11/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    // Views
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    // Constraints
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded() // trick that delays the next line of code to be executed. If not, there will be an error
            self.addChildViewController(menuViewController)
            menuViewController.view.frame = self.menuView.bounds
            menuViewController.willMoveToParentViewController(self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMoveToParentViewController(self)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if (oldContentViewController != nil) {
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            
            self.addChildViewController(contentViewController)
            contentViewController.view.frame = self.contentView.bounds
//            contentViewController.view.autoresizingMask = [.FlexibleHeight, .FlexibleTopMargin, .FlexibleBottomMargin]
            contentViewController.willMoveToParentViewController(self)
            contentView.addSubview(contentViewController.view)

            UIView.animateWithDuration(0.5, animations: {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
            contentViewController.didMoveToParentViewController(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.Changed {
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: {
                if velocity.x > 0 {
                    // Opening
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 60
                } else {
                    // Closing
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
        
    }

}

