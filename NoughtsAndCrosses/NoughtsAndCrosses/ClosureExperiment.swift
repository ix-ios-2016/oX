//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation


class ClosureExperiment {
    
    init() {
        self.thisIsAFunction("the string variable", withAClosure:self.anotherFunction)
    }
    
    func thisIsAFunction(withAInputVariable:String, withAClosure:() -> ()) {
        print("thisISAFunction is executing")
        withAClosure()
    }
    
    func anotherFunction()
    {
        
    }
}