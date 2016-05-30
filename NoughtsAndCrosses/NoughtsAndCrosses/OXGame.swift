//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

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

class OXGame {

    private var board = [CellType] (count: 9, repeatedValue: CellType.EMPTY)
    private var startType:CellType = CellType.X
    
    func turn() -> Int {
        
        var count = 0
        for cell in board {
            if (cell != CellType.EMPTY) {
                count = count + 1
            }
        }
            return count
    }
    
    func whosTurn() -> CellType {
        if (turn() % 2 == 0) {
            return CellType.O
        }   else {
            return CellType.X
        }
    }
    
    func typeAtIndex(index: Int) -> CellType {
        return board[index]
    }
    
    func playMove(index: Int) -> CellType {
        board[index] = whosTurn()
        return board[index]
    }
    
    func winDetection() -> Bool {
        if  (board[0] == "X" && board[1] == "X" && board[2] == "X") {
            return true
        } else if
            (board[3] == "X" && board[4] == "X" && board[5] == "X") {
            return true
        } else if
            (board[6] == "X" && board[7] == "X" && board[8] == "X") {
            return true
        } else if
            (board[0] == "X" && board[3] == "X" && board[6] == "X") {
            return true
        } else if
            (board[1] == "X" && board[4] == "X" && board[7] == "X") {
            return true
        } else if
            (board[2] == "X" && board[5] == "X" && board[8] == "X") {
            return true
        } else if
            (board[0] == "X" && board[4] == "X" && board[8] == "X") {
            return true
        } else if
            (board[2] == "X" && board[4] == "X" && board[6] == "X") {
            return true
        } else if
            (board[0] == "O" && board[1] == "O" && board[2] == "O") {
            return true
        } else if
            (board[3] == "O" && board[4] == "O" && board[5] == "O") {
            return true
        } else if
            (board[6] == "O" && board[7] == "O" && board[8] == "O") {
            return true
        } else if
            (board[0] == "O" && board[3] == "O" && board[6] == "O") {
            return true
        } else if
            (board[1] == "O" && board[4] == "O" && board[7] == "O") {
            return true
        } else if
            (board[2] == "O" && board[5] == "O" && board[8] == "O") {
            return true
        } else if
            (board[0] == "O" && board[4] == "O" && board[8] == "O") {
            return true
        } else if
            (board[2] == "O" && board[4] == "O" && board[6] == "O") {
            return true
        } else {
            return false
        }
        
    }
    
    func state() -> String {
        if  (winDetection() == true) {
            return complete_someone_won
        } else if
            (winDetection() == false &&  count > 8) {
            return complete_no_one_won
        } else {
            return inProgress
        }
    }
    
    func reset() {
        if (OXGame.state() == complete_someone_won && OXGame.state() == complete_no_one_won) {
            for (index, cell) in board.enumerate() {
                board.cell[index] = CellType.EMPTY
            }
        }
    }

}

