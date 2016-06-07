//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/7/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//
import Foundation
import UIKit

	class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    	    //MARK: Class Singleton
    class var sharedInstance: EasterEggController {
            struct Static {
            static var instance:EasterEggController?
            static var token: dispatch_once_t = 0
            	        }
        
            dispatch_once(&Static.token)    {
                Static.instance = EasterEggController()
            }
               return Static.instance!
            }
        
    
    func initiate (view:UIView) {
        
        let longPress = UILongPressGestureRecognizer()
        let rightSwipe = UISwipeGestureRecognizer ()
        let TwoFingerDownSwipe = UISwipeGestureRecognizer ()
        let ClockWiseRotation = UIRotationGestureRecognizer ()
        let CounterClockWise = UIRotationGestureRecognizer ()
        
    }
        
        //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
               }

    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


