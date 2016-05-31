//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

private let startType = CellType.X

enum CellType:String {

    case O = "O"
    case X = "X"
    case EMPTY = ""
    
}

enum OXGameState:String {
    case inProgress = "In Progress"
    case complete_no_one_won = "Complete, but no one won"
    case complete_someone_won = "Complete, and a player won"
}

class OXGame {
    
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    
    private func turn() -> Int {
        
        var count = 0
        
        for cell in board {
            if (cell != CellType.EMPTY) {
                count += 1
            }
            
        }
        
        print("turn is \(count)")
        return count
    }
    
    func whosTurn() -> CellType {
        
        if (turn() % 2 == 0) {
            return CellType.O
        } else {
            return CellType.X
        }
        
    }
    
    func typeAtIndex(index:Int) -> CellType {
        
        return board[index]
        
    }
    
    func playMove(move:Int) -> CellType {
        
        if (whosTurn() == CellType.X) {
            board[move] = CellType.X
            return board[move]
        } else {
            board[move] = CellType.O
            return board[move]
        }
        
    }
    
    func winDetection() -> Bool {
        
        var winner = false
        let types = [CellType.X, CellType.O]
        let winningBoards = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0, 4,8], [2,4,6]]
        for type in types {
            for winningBoard in winningBoards {
                if (board[winningBoard[0]] == type && board[winningBoard[1]] == type && board[winningBoard[2]] == type) {
                    winner = true
                }
            }
        }
        return winner
            
    }
        
    func state() -> OXGameState {
        
        if (winDetection() == true) {
            return OXGameState.complete_someone_won
        } else if (winDetection() == false && turn() == 9) {
            return OXGameState.complete_no_one_won
        } else {
            return OXGameState.inProgress
        }
        
    }
        
    func reset() {
        
         board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
        
    }
    
}