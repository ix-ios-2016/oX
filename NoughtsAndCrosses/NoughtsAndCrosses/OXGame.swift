//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class OXGame {

    private var board = [CellType](count:9,repeatedValue: CellType.EMPTY)
    private var startType = CellType.O
    
    enum CellType:String {
        case O = "O"
        case X = "X"
        case EMPTY = ""
    }
    
    enum OXGameState: String {
        case inProgress
        case complete_no_one_won
        case complete_someone_won
    }
    
    func turn() -> Int {
        var count = 0
        for cell in board {
            if cell != CellType.EMPTY {
                count = count + 1
            }
        }
        return count
    }
    
    func whosTurn() -> CellType {
        if turn() % 2 == 0 {
            return CellType.O
        } else {
            return CellType.X
        }
    }
    
    func typeAtIndex(index: Int) -> CellType {
        return board[index]
    }
    
    func playMove(index: Int) -> CellType {
        board[index] = self.whosTurn()
        return board[index]
    }
    
    func winDetection() -> Bool {
        if board[0]==board[1] && board [1]==board[2] && board[1] != CellType.EMPTY {
            return true
        }
        if board[3]==board[4] && board[4]==board[5] && board[4] != CellType.EMPTY {
            return true
        }
        if board[6]==board[7] && board[7]==board[8] && board[7] != CellType.EMPTY {
            return true
        }
        if board[0]==board[3] && board[3]==board[6] && board[3] != CellType.EMPTY {
            return true
        }
        if board[1]==board[4] && board[4]==board[7] && board[4] != CellType.EMPTY {
            return true
        }
        if board[2]==board[5] && board[5]==board[8] && board[5] != CellType.EMPTY {
            return true
        }
        if board[0]==board[4] && board[4]==board[8] && board[4] != CellType.EMPTY {
            return true
        }
        if board[6]==board[4] && board[4]==board[2] && board[4] != CellType.EMPTY {
            return true
        } else {
            return false
        }
    }
    

    func state() -> OXGameState {
        let won = winDetection()
        if won {
            return OXGameState.complete_someone_won
        } else if !won && turn() == 9 {
            return OXGameState.complete_no_one_won
        } else {
            return OXGameState.inProgress
        }
    }

    func reset() {
        var i = 0
        while i < 9{
            board[i] = CellType.EMPTY
            i = i + 1
            
        }
    
    }
    
   
    
    
}
