//
//  UserController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-31.
//  Copyright © 2016 Julian Hulme. All rights reserved.
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
    
    // KASRA'S EXTRA FUNCTION
//    func loadUsers() {
//        for (key, pass) in NSUserDefaults.standardUserDefaults().dictionaryRepresentation() {
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//            if emailTest.evaluateWithObject(key) {
//                // is an email key
//                self.users.append(User(email: key, password: pass as! String))
//            }
//        }
//    }
    
    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?) {
        for user in users {
            if user.email == newEmail {
                return ("Email taken", nil)
            }
        }
        let user = User(email: newEmail, password: newPassword)
        self.users.append(user)
        self.logged_in_user = user
        self.storeUser(user)
        print("User with email: \(newEmail) has been registered by the UserManager.")
        return (nil, user)
    }
    
    func loginUser(suppliedEmail: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        for user in users {
            if user.email == suppliedEmail {
                if user.password == suppliedPassword {
                    logged_in_user = user
                    print("User with email: \(suppliedEmail) has been logged in by the UserManager.")
                    NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
                    return (nil, user)
                } else {
                    return ("Password incorrect", nil)
                }
            }
        }
        
        return ("No user with that email", nil)
    }
    
    func storeUser(user: User) {
        NSUserDefaults.standardUserDefaults().setObject(user.password, forKey: "\(user.email)")
    }
    
    func getStoredUser(id: String) -> User? {
        if let userPassword: String = NSUserDefaults.standardUserDefaults().objectForKey(id) as? String {
            // user found
            let user = User(email: id, password: userPassword)
            return user
        } else {
            // user not found
            return nil
        }
    }
    
    func logoutUser() {
        // set data values
        logged_in_user = nil
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
    }
}