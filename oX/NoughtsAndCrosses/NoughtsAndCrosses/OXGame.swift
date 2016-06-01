//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Joe Salter on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

private let maxTurns:Int = 9

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
    private var board = [CellType](count: maxTurns, repeatedValue: CellType.EMPTY)

    // Starting type
    private var startType: CellType = CellType.X
    
    // Keep track of number of turns
    private var turnCount:Int = 0
    
    // Return number of turns
    func turn() -> Int {
        return turnCount
    }
    
    // Returns if it’s the CellType.O or CellType.X turn
    func whosTurn() -> CellType {
        if (turnCount % 2 == 0) {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
    
    // Returns the CellType at a certain position of the board
    func typeAtIndex(index: Int) -> CellType {
        return board[index]
    }
    
    // Takes an Int as an input, updates the board, and returns the CellType of that move.
    func playMove(index: Int) -> CellType {
        board[index] = whosTurn()
        turnCount += 1
        return board[index]
    }
    
    // Determine if someone has won the game
    func winDetection() -> Bool {
        if turnCount > 4 {
            if ((board[0] == board[1] && board[1] == board[2] && board[0] != CellType.EMPTY) ||
                (board[3] == board[4] && board[4] == board[5] && board[3] != CellType.EMPTY) ||
                (board[6] == board[7] && board[7] == board[8] && board[6] != CellType.EMPTY) ||
                
                (board[0] == board[3] && board[3] == board[6] && board[0] != CellType.EMPTY) ||
                (board[1] == board[4] && board[4] == board[7] && board[1] != CellType.EMPTY) ||
                (board[2] == board[5] && board[5] == board[8] && board[2] != CellType.EMPTY) ||
                
                (board[0] == board[4] && board[4] == board[8] && board[0] != CellType.EMPTY) ||
                (board[2] == board[4] && board[4] == board[6] && board[2] != CellType.EMPTY))
            {
                return true
            }
        }
        return false
    }
    
    // Return current state of the game
    func state() -> OXGameState {
        if winDetection() {
            return OXGameState.complete_someone_won
        }
        else if turnCount == maxTurns {
            return OXGameState.complete_no_one_won
        }
        else {
            return OXGameState.inProgress
        }
    }
    
    // Sets all the board cells to CellType.Empty
    func reset() {
        for index in 0...8 {
            board[index] = CellType.EMPTY
        }
    }
}