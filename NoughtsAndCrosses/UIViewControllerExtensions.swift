//  UIViewControllerExtensions.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/06/05.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

public let LOADING_OVERLAY_VIEW_TAG = 987432

extension UIViewController  {
    
    
    //MARK: Loading screen actions
    func addLoadingOverlay  ()   {
        
        self.makeViewDropKeyboard()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //add an overlay screen
        let overlayImage = UIImageView(frame: self.view.frame)
        overlayImage.backgroundColor = UIColor.blackColor()
        overlayImage.alpha = 0.5
        overlayImage.tag = LOADING_OVERLAY_VIEW_TAG
        
        
        /*these two lines still allow for navigation controller (back button) to be pressed */
        //self.view.userInteractionEnabled = false
        //overlayImage.userInteractionEnabled = false
        
        /* this does not allowed for anything on the screen to be pressed,
         * need to make userInteractionEnabled return to true in removeLoadingOverlay()
         */
        appDelegate.window!.userInteractionEnabled = false
        
        let loadingSpinner = UIActivityIndicatorView(frame: overlayImage.frame)
        loadingSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        loadingSpinner.startAnimating()
        overlayImage.addSubview(loadingSpinner)
        
        
        return appDelegate.window!.addSubview(overlayImage)
    }
    
    func removeLoadingOverlay()  {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //after loading, user interaction is enabled again
        appDelegate.window!.userInteractionEnabled = true
        
        for view in appDelegate.window!.subviews  {
            if (view.tag == LOADING_OVERLAY_VIEW_TAG)   {
                view.removeFromSuperview()
            }
        }
        
        
    }
    
    func makeViewDropKeyboard()   {
        print("makeViewDropTapped")
        self.view.endEditing(true);
        self.resignFirstResponder()
    }
    
    
    
}