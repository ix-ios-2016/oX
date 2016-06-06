//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation


class ClosureExperiment {
    
    init() {
        //experiment 1
        // self.anotherFunction()
        self.thisIsAFunction("the string variable" , withAClosure : self.anotherFunction)
    }
    
    func thisIsAFunction(withAnInputVariable : String , withAClosure:() -> ()) {
        //self.navigationController?.pushViewController(LoginViewController , )
        
        print("thisIsAFunction is executing")
        withAClosure() //this function will be executed when this line occurs
    }
    
    func anotherFunction() {
        print ("another function is executing")
    }
}