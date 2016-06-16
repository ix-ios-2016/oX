import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {

    
    struct key{
        var long = 0
        var right = 0
        var down = 0
        var clock = 0
        var counter = 0
    }
    
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
        
        // Long Press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        // Right Swipe
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        // Two Finger Down Swipe
        let twoDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoDownSwipe(_:)))
        twoDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        twoDownSwipe.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoDownSwipe)
        
        // RotationClockwise
        let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)
        
        rotation.delegate = self
        
 
    }
    
    var gestures = key()
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil){
        gestures.long = 1
        print("Long Press!")
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil){
        if (gestures.long == 1){
            gestures.right = 1
        }
        else{
            gestures.long = 0
            gestures.right = 0
        }
        print("Right Swipe")
    }
    
    func handleTwoDownSwipe(sender: UISwipeGestureRecognizer? = nil){
        if (gestures.right == 1){
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggScreen()
        }
        else{
            gestures.long = 0
            gestures.right = 0
            gestures.down = 0
        }
        gestures.down = 1
        print ("Two Finger Swipe down")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil){
        
        if (sender!.state == UIGestureRecognizerState.Ended){
            
            if sender?.rotation > 0 {
                gestures.clock = 1
                print("Rotation Clock")
            }
            else{
                gestures.counter = 1
                print("Rotation Counter")
            }
        }
        
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
