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
        if  ((board[0] == board[1]) && (board[0] == board[2]) && !(board[0] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[3] == board[4]) && (board[3] == board[5]) && !(board[3] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[6] == board[7]) && (board[6] == board[8]) && !(board[6] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[0] == board[3]) && (board[0] == board[6]) && !(board[0] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[1] == board[4]) && (board[1] == board[7]) && !(board[1] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[2] == board[5]) && (board[2] == board[8]) && !(board[2] == CellType.EMPTY)) {
            return true
        }   else if
            ((board[0] == board[4]) && (board[0] == board[8]) && !(board[0] == CellType.EMPTY)) {
            return true
        }   else {
            return false
        }
    }
    
    func state() -> OXGameState {
        if  (winDetection() == true) {
            return OXGameState.complete_someone_won
        } else if
            ((winDetection() == false) &&  (turn() > 8)) {
            return OXGameState.complete_no_one_won
        } else {
            return OXGameState.inProgress
        }
    }
    
    func reset() {
        for index in 0...(board.count - 1) {
            board[index] = CellType.EMPTY
        }
    }
}

