//
//  UserManager.swift
//  OnboardingApp
//
//  Created by Josh Broomberg on 2016/05/28.
//  Copyright © 2016 iXperience. All rights reserved.
//

import Foundation
import Alamofire

class User: NSObject, NSCoding
{
    var email: String!
    var password: String!
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObjectForKey("email") as? String
        let password = aDecoder.decodeObjectForKey("password") as? String
        self.init(email: email!, password: password!)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(email!, forKey: "email")
        aCoder.encodeObject(password!, forKey: "password")
    }
}

class UserController {
    // Singleton design pattern
    class var sharedInstance: UserController {

        dispatch_once(&Static.token)    {
            Static.instance = UserController()
        }
        return Static.instance!
    }
    
    struct Static {
        static var instance:UserController?
        static var token: dispatch_once_t = 0
    }

    
    // MARK: MAKE THIS A NSUSERDEFAULT
    //var logged_in_user: User?
    
    //MAKE A SET LOGIN USER ALSO
    func setLoggedInUser(user:User) {
        
        // store the user data
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(user)
        userDefaults.setObject(encodedData, forKey: "userLoggedIn")
        userDefaults.synchronize()
        
    }
    
    // return optional User
    func getLoggedInUser() -> User? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let decoded = userDefaults.objectForKey("userLoggedIn") as? NSData {
            let decodedUser = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as? User
            return decodedUser
        }
        else {
            return nil
        }
    }
    
    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?)
    {
        let user = User(email: newEmail, password: newPassword)
        
        // use the new storing function
        if self.getStoredUser(newEmail) == nil
        {
            // store the user with persistence function
            storeUser(user)
            
            self.setLoggedInUser(user)
            
            print("User with email: \(newEmail) has been registered by the UserManager.")
            
            // Log in that user
            loginUser(newEmail, suppliedPassword: newPassword)
            
            
            return (nil, user)
        }
        else {
            return ("The email " + newEmail + " already taken", nil)
        }
    }
    
    func loginUser()    {
        
        Alamofire.request(.POST, "https://ox-backend.herokuapp.com/auth", parameters: ["email": "asdf@afd.com","password":"asdf"])
            .responseJSON { response in

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                print(response)
        }

    
    }
    
    
    func loginUser(suppliedEmail: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        
        if let user = getStoredUser(suppliedEmail)
        {
            if user.email == suppliedEmail
            {
                if user.password == suppliedPassword
                {
                    if let logged_in_user = self.getLoggedInUser()
                    {
                        self.setLoggedInUser(logged_in_user)
                    }
                    
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
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userLoggedIn")
    }
    
    // PERSISTENCE FUNCTIONS ***********************************************************
    
    // store the user
    func storeUser(user:User) {
        // store all users
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
        }
        else
        {
            // user not found
            return nil
        }
    }
}