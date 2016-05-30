//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-30.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation


enum CellType: String {
    case O = "O"
    case X = "X"
    case EMPTY = ""
}

enum OXGameState: String {
    case inProgress = "Game in progress"
    case complete_no_one_won = "Tie"
    case complete_someone_won = "Game over"
}

class OXGame {
    // variable storing the board state
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    
    // variable denoting starting player
    private var startType: CellType = CellType.X
    
    // functionin returning number of turns already passed
    private func turn() -> Int {
        var count = 0
        for cell in board {
            if (cell != CellType.EMPTY) {
                count += 1
            }
        }
        return count
    }
    
    // tell the ViewController whose turn it is
    func whosTurn() -> CellType {
        if (turn() % 2 == 0) {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
    
    // return the cell type at a given position
    func typeAtIndex(pos: Int) -> CellType {
        return board[pos]
    }
    
    // update the board based on the given input
    func playMove(pos: Int) -> CellType {
        let currentPlayer = whosTurn()
        board[pos] = currentPlayer
        return currentPlayer
    }
    
    // determine whether the game is over
    // true if some player won, false otherwise
    private func winDetection() -> Bool {
        return false
    }
    
    // return the state of the game
    func state() -> OXGameState{
        let winnerExists = winDetection()
        if winnerExists {
            return OXGameState.complete_someone_won
        }
        else if turn() == 9 {
            return OXGameState.complete_no_one_won
        }
        else {
            return OXGameState.inProgress
        }
    }
    
    // set all the board cells to empty
    func reset() {
        for i in 0..<9 {
            board[i] = CellType.EMPTY
        }
    }
}