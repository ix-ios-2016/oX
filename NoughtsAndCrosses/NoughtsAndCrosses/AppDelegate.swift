//
//  AppDelegate.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/05/02.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var gameNavigationController : UINavigationController?
    
    var authorizationNavigationController : UINavigationController?
    
    var easterEggNavigationController : UINavigationController?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.gameNavigationController?.navigationBarHidden = true
        //Always have this line at the top of the application function to confirm that a window does exist
        self.window = UIWindow(frame : UIScreen.mainScreen().bounds)
        
        //set to stored persistent value
        let userIsLoggedIn = NSUserDefaults.standardUserDefaults().objectForKey("userIsLoggedIn")
      
        if let _ = (userIsLoggedIn) {
            navigateToGame()
        } else {
            //This is for if there is no value for the objectForKey which means this is the first time this has run
            navigateToLandingViewController()
        }
        
        //This gets you to the Easter Egg page from every page in the entire app!!! From Julian.
        EasterEggController.sharedInstance.initiate(self.window!)
        
        //Have this at the end of the application() method to ensure that everything is set up
        self.window?.makeKeyAndVisible()
        return true
        }
    
    
    func navigateToLandingViewController() {
        let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
        authorizationNavigationController = UINavigationController(rootViewController: landingViewController)
        self.window?.rootViewController = self.authorizationNavigationController
        

    }
    
    func navigateToGame() {
        
        let gameBoard = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.gameNavigationController = UINavigationController(rootViewController: gameBoard)
        self.window?.rootViewController = self.gameNavigationController
    }
    
    func navigateToEasterEggScreen() {
        let easterEggViewController = EasterEggViewController(nibName: "EasterEggViewController",bundle: nil)
        easterEggNavigationController = UINavigationController(rootViewController: easterEggViewController)
        self.window?.rootViewController = easterEggNavigationController
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

