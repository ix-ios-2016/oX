//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class OXGame {
    enum CellType:String {
        case O = "O"
        case X = "X"
        case EMPTY = ""
    }
    
    enum OXGameState:String {
        case inProgress
        case complete_no_one_won
        case complete_someone_won
    }
    
    // Initiaize a board of 9 empty cells
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    // Decide which cellType goes first in the game
    private var startType:CellType = CellType.X
    
    private var turnCount:Int = 0

    // Return the amount of turns played
    func turn() -> Int {
        return turnCount
    }
    
    // Return whose turn it is
    func whoseTurn() -> CellType
    {
        // Game always starts with X going first, so can use this logic
        if turnCount % 2 == 0 {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
}