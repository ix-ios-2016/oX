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
    var navigationController: UINavigationController?
    var authorisationNavController: UINavigationController?
    var easterEggNavController: UINavigationController?
    
    
    /* function that gets called when app starts */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.navigationController?.navigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        
        
        //set to stored persistant value
        let userIsLoggedIn = NSUserDefaults.standardUserDefaults().objectForKey("userIsLoggedIn")
        //(if userIsLoggedIn value != nil
        if let loggedIn = userIsLoggedIn  {
            navigateToBoardViewController()
        }
        else {
            navigateToLandingViewController()
        }
        
        
        EasterEggController.sharedInstance.initiate(self.window!)
        
        return true
    }
    
    func  navigateToLandingViewController() {
        
        let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
        authorisationNavController = UINavigationController(rootViewController: landingViewController)
        self.window?.rootViewController = self.authorisationNavController
        
    }
    
    func  navigateToBoardViewController() {
        
        let boardViewController = BoardViewController(nibName:"BoardViewController",bundle:nil)
        navigationController = UINavigationController(rootViewController: boardViewController)
        self.navigationController?.navigationBarHidden = true
        self.window?.rootViewController = self.navigationController
        
    }
    
    func  navigateToEasterEggScreen() {
        
        let easterEggViewController = EasterEggViewController(nibName:"EasterEggViewController",bundle:nil)
        easterEggNavController = UINavigationController(rootViewController: easterEggViewController)
        self.easterEggNavController?.navigationBarHidden = true
        self.window?.rootViewController = self.easterEggNavController
        
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

