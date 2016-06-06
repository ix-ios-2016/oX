//
//  ClosureExperiment.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-06-06.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class ClosureExperiment {
    init() {
        self.anotherFunction()
    }
    
    func thisIsAFunction(withAnInputVariable: String, withAClosure: () -> ()) {
        print("thisIsAFunction is executing")
        withAClosure()
    }
    
    func anotherFunction() {
        print("another function is executing")
    }
}