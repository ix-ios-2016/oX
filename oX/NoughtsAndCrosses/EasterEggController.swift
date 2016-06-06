import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    var correctSequence:[String] = ["CLOCKWISE ROTATION", "LONG PRESS", "RIGHT SWIPE", "TWO FINGER DOWN"]
    var currentSequence:[String] = []
    
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
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)
        
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
    
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        let twoFingerDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerDown(_:)))
        twoFingerDown.numberOfTouchesRequired = 2
        twoFingerDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(twoFingerDown)
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        if (sender!.state == UIGestureRecognizerState.Ended) {
            if (sender!.rotation > 0) {
                print("CLOCKWISE ROTATION")
                currentSequence.append("CLOCKWISE ROTATION")
            }
            else if (sender!.rotation < 0) {
                print("COUNTERCLOCKWISE ROTATION")
                currentSequence.append("CLOCKWISE ROTATION")
            }
        }
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("LONG PRESS")
            currentSequence.append("LONG PRESS")
        }
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("RIGHT SWIPE")
            currentSequence.append("RIGHT SWIPE")
        }
    }
    
    func handleTwoFingerDown(sender: UISwipeGestureRecognizer? = nil) {
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("TWO FINGER SWIPE")
            currentSequence.append("TWO FINGER DOWN")
            
            if validate() {
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToLoggedInNavigationController()
                appDelegate.navigateToEasterEggScreen()
            }
        }
    }
    
    func validate() -> Bool {
        
        if (currentSequence.count < 4) {
            return false
        }
        
        let start = currentSequence.endIndex - 4
        if (currentSequence[start..<currentSequence.endIndex] == ArraySlice(correctSequence)) {
            print("corect")
            return true
        }
        
        else {
            return false
        }
    }
}