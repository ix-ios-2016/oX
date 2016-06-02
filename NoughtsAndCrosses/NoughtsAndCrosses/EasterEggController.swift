//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Rachel on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    
    enum gesture{
        case ClockwiseRotation
        case CounterClockwiseRotation
        case RightSwipe
        case LongPress
        case DownSwipe
        case none
    }
    
    var lastGesture = gesture.none

    let gesturesCombo = ["RightSwipe", "DownSwipe", "LongPress"]
    var index = 0
    
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
    
    
    func initiate(view:UIView) {


        //rotations
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)

        //rightSwipe
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        //longPress
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(EasterEggController.handlelongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        //downSwipe
        let downSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handledownSwipe(_:)))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
    
        
    }
    
    func checkKey(){
        if (index == gesturesCombo.endIndex) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToEasterEggScreen()
        index = 0
        
    }
        else {
            return
        }
    }

    //rotation handler
    func handleRotation( sender: UIRotationGestureRecognizer? = nil  ){
        
    if (sender!.state == UIGestureRecognizerState.Ended)
        {
        
            if ( sender!.rotation < 0 ){
                print("CCR Detected")
            }
            else {
                print("CR Detected")
            }
        }
    }
    
    //right swipe handler
    func handleRightSwipe( sender: UISwipeGestureRecognizer? = nil  ){

        print("Right Swipe Detected")
        if ( gesturesCombo[index] == "RightSwipe"){
            index += 1
            checkKey()
        }
        else {
            index = 0
        }
        
    }
    
    //long press handler
    func handlelongPress( sender: UILongPressGestureRecognizer? = nil  ){
        
        print("Long Press Detected")
        if ( gesturesCombo[index] == "LongPress" ){
            index += 1
            checkKey()
        }
        else {
            index = 0
        }
  
        
    }
    
    //down swipe handler
    func handledownSwipe( sender: UISwipeGestureRecognizer? = nil  ){

       print("Down Swipe Detected")
        if ( gesturesCombo[index] == "DownSwipe"){
            index += 1
            checkKey()
        }
        else {
            index = 0
        }


    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}