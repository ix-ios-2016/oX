//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class ClosureExperiment {
    
    init() {
        self.thisIsAFunction("the string variable", withAClosure: self.anotherFunction)
    }
    
    func thisIsAFunction(withAnInputVariable: String, withAClosure: () -> ()) {
        
        print("thisIsAFunction is executing \(withAnInputVariable)")
        withAClosure()
        
    }
    
    func anotherFunction() {
        print("another function is executing")
    }
    
    
}