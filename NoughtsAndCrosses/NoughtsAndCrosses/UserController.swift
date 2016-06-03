//
//  UserController.swift
//  OnboardingApp
//
//  Created by Josh Broomberg on 2016/05/28.
//  Copyright © 2016 iXperience. All rights reserved.
//

import Foundation

struct User {
    var email: String
    var password: String
}

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
    
    private var users: [User] = []
    
    var logged_in_user: User?
    
    func logout() {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        logged_in_user = nil
    }
    
    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?) {
        for user in users {
            if user.email == newEmail {
                return ("Email taken", nil)
            }
        }
        let user = User(email: newEmail, password: newPassword)
        self.storeUser(user)
        logged_in_user = user
        NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
        print("User with email: \(newEmail) has been registered and logged in by the UserController.")
        return (nil, user)
    }
    
    func loginUser(suppliedEmail: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        if let user = self.getStoredUser(suppliedEmail) {
            if user.email == suppliedEmail {
                if user.password == suppliedPassword {
                    NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
                    logged_in_user = user
                    print("User with email: \(suppliedEmail) has been logged in by the UserController.")
                    return (nil, user)
                } else {
                    return ("Password incorrect", nil)
                }
            }
        }
        
        return ("No user with that email", nil)
    }
    
    func storeUser(user: User) {
        
        NSUserDefaults.standardUserDefaults().setObject(user.password, forKey: user.email)
        
    }
    
    func getStoredUser(id: String) -> User? {
        
        if let userPassword: String = NSUserDefaults.standardUserDefaults().stringForKey(id) {
            return User(email: id, password: userPassword)
        }
        else {
            return nil
        }
        
    }
}