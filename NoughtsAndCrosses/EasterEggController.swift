//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {


    struct gestures {
    
        var CCWRotation : Int = 0
        var CWRotation : Int = 0
        var rightSwipe : Int = 0
        var twoFingerDownSwipe : Int = 0
        var longPress : Int = 0
    
    }
    
    var lastGesture = gestures()
    
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
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func initiate(view:UIView) {
        
        //TODO: Recognize clockwise and counterclockwise rotations!!
         let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(EasterEggController.handleRotation(_:)))
         view.addGestureRecognizer(rotation)

         //A rightward swipe is the default direction
         let rightSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handleRightSwipe(_:)))
         view.addGestureRecognizer(rightSwipe)

        
         let twoFingerDownSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
         twoFingerDownSwipe.numberOfTouchesRequired = 2
        
         view.addGestureRecognizer(twoFingerDownSwipe)
        
         let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(EasterEggController.handleLongPress(_:)))
         view.addGestureRecognizer(longPress)
    }
    
    func handleLongPress (sender : UILongPressGestureRecognizer? = nil) {
        
        //lastGesture = gestures.longPress
        lastGesture.longPress = 1
        print("Long Press Recognized")
    }
    func handleRightSwipe (sender : UISwipeGestureRecognizer? = nil) {
        //self.lastGesture = gesture.rightSwipe
        print("jr")
        if (lastGesture.longPress == 1) {
            lastGesture.rightSwipe = 1
        } else {
            lastGesture.rightSwipe = 0
            lastGesture.longPress = 0
        }
    }
    
    func handleTwoFingerDownSwipe (sender : UISwipeGestureRecognizer? = nil) {
        //self.lastGesture = gesture.twoFingerDownSwipe
        
        if ((lastGesture.longPress == 1) && (lastGesture.rightSwipe == 1)) {
            lastGesture.twoFingerDownSwipe = 1
        } else {
            lastGesture.rightSwipe = 0
            lastGesture.longPress = 0
            lastGesture.twoFingerDownSwipe = 0
        }

        
        print("Swipe gesture recognized (is it two finger and down?")
    }
    
    func handleRotation(sender : UIRotationGestureRecognizer? = nil) {
       
        //self.lastGesture = gesture.rotation
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            if (sender!.rotation < 0){
             //   self.lastGesture = gesture.CCWRotation
                print("CCWR")
            } else {
            //    self.lastGesture = gesture.CWRotation
                print("CWR")
            }
            
            if ((lastGesture.longPress == 1) && (lastGesture.rightSwipe == 1) && (lastGesture.twoFingerDownSwipe == 1)){
                if (sender!.rotation > 0) {
                    lastGesture.CWRotation = 1
                } else {
                    lastGesture.rightSwipe = 0
                    lastGesture.longPress = 0
                    lastGesture.twoFingerDownSwipe = 0
                }
            }
            if ((lastGesture.longPress == 1) && (lastGesture.rightSwipe == 1) && (lastGesture.twoFingerDownSwipe == 1) && (lastGesture.CWRotation == 1)) {
                if(sender!.rotation < 0){
                    lastGesture.CCWRotation = 1
                }
            }
            else {
                lastGesture.rightSwipe = 0
                lastGesture.longPress = 0
                lastGesture.twoFingerDownSwipe = 0
                lastGesture.CWRotation = 0
            }
            if (lastGesture.CCWRotation == 1) {
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
                
                appDelegate.navigateToEasterEggScreen()
            }
        }

    }
}

