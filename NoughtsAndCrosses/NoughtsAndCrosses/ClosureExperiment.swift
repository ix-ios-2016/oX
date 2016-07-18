//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Ryan Davey on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class ClosureExperiment {
    
    init() {
        self.thisIsAFunction("the string variable", withAClosure:self.anotherFunction)
        self.anotherFunction()
    }
    
    func thisIsAFunction(withAInputVariable:String, withAClosure:() -> ()) {
        print("thisIsAFunction is executing \(withAInputVariable)")
        withAClosure() //this function will be executed when this line occurs
    }
    
    func anotherFunction() {
        print("another function is executing")
    }
    
}