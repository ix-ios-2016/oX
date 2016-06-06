//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Rachel on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class ClosureExperiment {
    
    
    
    init () {
        self.anotherFunction()
    }
    
    func thisIsAFunction(withAnInputVariable:String, withAClosure: () -> ()){
        print("thisIsAFunction is executing")
        withAClosure()
    }
    
    func anotherFunction(){
        print("Another Function is executing")
    }
    
    
    
}