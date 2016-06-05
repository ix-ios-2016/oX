//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

enum CellType : String {
    case O = "O"
    case X = "X"
    case EMPTY = ""
}

enum OXGameState : String {
    case inProgress
    case complete_no_one_won
    case complete_someone_won
}

class OXGame {
    
    var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    
    var hostUser: User?
    var guestUser: User?
    var backendState: OXGameState?
    var gameId: String?
    
    // turn as int
    private func turn() -> Int {
        
        var count = 0
        for cell in board {
            if cell != CellType.EMPTY {
                count += 1
            }
        }
        return count
        
    }
    
    
    // turn as type
    func whosTurn() -> CellType {
        
        if (turn() % 2) == 0 {
            return CellType.X
        }
        else {
            return CellType.O
        }
        
    }
    
    
    // return CellType at specified cell
    func typeAtIndex(index: Int) -> CellType {
        
        switch board[index] {
        case CellType.O:
            return CellType.O
        case CellType.X:
            return CellType.X
        default:
            return CellType.EMPTY
        }
        
    }
    
    
    // play CellType move and specified cell only if cell is empty
    func playMove(index: Int) -> CellType {
        
        let cellType = whosTurn()
        if typeAtIndex(index) == CellType.EMPTY {
            board[index] = cellType
            return cellType
        }
        else {
            return CellType.EMPTY
        }
        
    }
    
    
    // check for a winning game
    func winDetection() -> Bool {
        
        func check(cell: Int, with: Int, and: Int) -> Bool {
            return typeAtIndex(cell) != CellType.EMPTY && typeAtIndex(cell) == typeAtIndex(with) && typeAtIndex(with) == typeAtIndex(and)
        }
        
        if check(0, with: 1, and: 2) || check(0, with: 3, and: 6) || check(0, with: 4, and: 8) || check(3, with: 4, and: 5) || check(6, with: 7, and: 8) || check(1, with: 4, and: 7) || check(2, with: 5, and: 8) || check(2, with: 4, and: 6) {
            return true
        }
        else {
            return false
        }
        
    }
    
    // return OXGameState by checking for win or tie
    func state() -> OXGameState {
        
        let won = winDetection()
        if won {
            return OXGameState.complete_someone_won
        }
        else if turn() == 9 {
            return OXGameState.complete_no_one_won
        }
        else {
            return OXGameState.inProgress
        }
    
    }
    
    // reset the board to be empty
    func reset() {
        board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    }
    
}