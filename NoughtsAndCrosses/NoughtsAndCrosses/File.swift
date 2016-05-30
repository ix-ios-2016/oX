//
//  File.swift
//  NoughtsAndCrosses
//
//  Created by Serene Mirza on 5/30/16.
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
    
    private var startType = CellType.X
    
    private func turn() -> Int {
        
        var count = 0
        for cell in board {
            if cell != CellType.EMPTY {
                count += 1
            }
        }
        return count
    }
    
    func whosTurn() -> CellType {
        if (turn() % 2 == 0) {
            return CellType.O
        }
        else {
            return CellType.X
        }
    }
    
    func typeAtIndex(index: Int) -> CellType {
        return board[index]
    }
    
    func playMove(index: Int) -> CellType {
        if board[index] == CellType.EMPTY {
            board[index] = whosTurn()
            return board[index]
        }
        else {
            return board[index]
        }
    }
    
    func winDetection() -> Bool {
        if ((board[0] == board[1]) && (board[1] == board[2]) && (board[2] != CellType.EMPTY))
            || ((board[3] == board[4]) && (board[4] == board[5]) && (board[5] != CellType.EMPTY))
            || ((board[6] == board[7]) && (board[7] == board[8]) && (board[8] != CellType.EMPTY))
            || ((board[0] == board[3]) && (board[3] == board[6]) && (board[6] != CellType.EMPTY))
            || ((board[1] == board[4]) && (board[4] == board[7]) && (board[7] != CellType.EMPTY))
            || ((board[2] == board[5]) && (board[5] == board[8]) && (board[8] != CellType.EMPTY))
            || ((board[0] == board[4]) && (board[4] == board[8]) && (board[8] != CellType.EMPTY))
            || ((board[2] == board[4]) && (board[4] == board[6]) && (board[6] != CellType.EMPTY)) {
                return true
        }
        else {
            return false
        }
    }
    
    func state() -> OXGameState {
        
        //if someone won
        if winDetection() == true {
            return OXGameState.complete_someone_won
        }
        //tie
        else if turn() == 9 {
            return OXGameState.complete_no_one_won
        }
        //game not over
        else {
            return OXGameState.inProgress
        }
        
    }
    
    func reset() {
        for index in 0...8 {
            board[index] = CellType.EMPTY
        }
    }
    
}