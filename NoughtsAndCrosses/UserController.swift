//
//  UserManager.swift
//  OnboardingApp
//
//  Created by Josh Broomberg on 2016/05/28.
//  Copyright © 2016 iXperience. All rights reserved.
//

import Foundation

class UserController {
    // Singleton design pattern
    class var sharedInstance: UserController {
        struct Static {
            static var instance:UserController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = UserController()
        }
        return Static.instance!
    }
    
    struct User {
        var email: String
        var password: String
    }
    
    var logged_in_user: User?
    
    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?)
    {
        let user = User(email: newEmail, password: newPassword)
        
        // use the new storing function
        if getStoredUser(newEmail) == nil
        {
            // store the user with persistence function
            storeUser(user)
            
            logged_in_user = user
            print("User with email: \(newEmail) has been registered by the UserManager.")
            return (nil, user)
        }
        else {
            return ("The email " + newEmail + " already taken", nil)
        }
    }
    
    func loginUser(suppliedEmail: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        
        if let user = getStoredUser(suppliedEmail)
        {
            if user.email == suppliedEmail
            {
                if user.password == suppliedPassword
                {
                    logged_in_user = user
                    // delete the user data
                    NSUserDefaults.standardUserDefaults().setValue("true", forKey: "userIsLoggedIn")
                    print("User with email: \(suppliedEmail) has been logged in by the UserManager.")
                    return (nil, user)
                }
                else
                {
                    return ("Password incorrect", nil)
                }
            }
        }
        return ("No user with that email", nil)
    }
    
    func logoutUser()
    {
        // delete the user data
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
    }
    
    // PERSISTENCE FUNCTIONS ***********************************************************
    
    // store the user
    func storeUser(user:User) {
        NSUserDefaults.standardUserDefaults().setObject(user.password, forKey: user.email)
    }
    // get the user
    func getStoredUser(id:String) -> User?
    {
        if let userPassword:String = NSUserDefaults.standardUserDefaults().objectForKey(id) as? String
        {
            // user is found
            let user = User(email: id, password: userPassword)
            return user
        } else {
            // user not found
            return nil
        }
    }
}