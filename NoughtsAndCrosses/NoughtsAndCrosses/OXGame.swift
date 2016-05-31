//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

private let MAX_TURNS = 9

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
    private var board = [CellType](count: MAX_TURNS, repeatedValue: CellType.EMPTY)
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
    
    // Return the CellType of the board at the index given
    func typeAtIndex(index:Int) -> CellType {
        return board[index]
    }
    
    // Takes an Int as an input, updates the board, and returns the CellType of that move.
    func playMove(index:Int) -> CellType {
        // Use the whoseTurn function to write the X or O on the board
        board[index] = whoseTurn()
        
        turnCount += 1
        return board[index]
    }
    
    func winDetection() -> Bool
    {
        // horizontal
        if ((board[0] == board[1] && board[1] == board[2] && board[0] != CellType.EMPTY) ||
            (board[3] == board[4] && board[4] == board[5] && board[3] != CellType.EMPTY) ||
            (board[6] == board[7] && board[7] == board[8] && board[6] != CellType.EMPTY) ||
        // vertical
            (board[0] == board[3] && board[3] == board[6] && board[0] != CellType.EMPTY) ||
            (board[1] == board[4] && board[4] == board[7] && board[1] != CellType.EMPTY) ||
            (board[2] == board[5] && board[5] == board[8] && board[2] != CellType.EMPTY) ||
        // diagonal
            (board[0] == board[4] && board[4] == board[8] && board[0] != CellType.EMPTY) ||
            (board[2] == board[4] && board[4] == board[6] && board[2] != CellType.EMPTY))
        {
            return true
        }
        else {
            return false
        }
    }
    
    func state() -> OXGameState
    {
        let didWin:Bool = winDetection()
        
        if didWin {
            return OXGameState.complete_someone_won
        }
        else if turnCount == MAX_TURNS {
            return OXGameState.complete_no_one_won
        }
        else {
            return OXGameState.inProgress
        }
    }
    
    func reset()
    {
        for index in 0...8 {
            board[index] = CellType.EMPTY
        }
    }
}