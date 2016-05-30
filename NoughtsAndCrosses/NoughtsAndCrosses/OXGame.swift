//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Joe Salter on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class OXGame {
    enum CellType: String {
        case O = "O"
        case X = "X"
        case EMPTY = ""
    }
    
    enum OXGameState: String {
        case inProgress
        case complete_no_one_won
        case complete_someone_won
    }
    
    // The board, stored as array of 9 CellTypes, initialized to case Empty
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)

    // Starting type
    private var startType: CellType = CellType.X
    
    // Keep track of number of turns
    private var turnCount:Int = 0;
    
    // Return number of turns
    func turn() -> Int {
        return turnCount
    }
    
    // Return who's turn it is, either X's or O's (type CellType)
    func whosTurn() -> CellType {
        if (turnCount % 2 == 0) {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
    
    
    
}