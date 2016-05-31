//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

enum CellType:String {
    
    case X = "X"
    case O = "O"
    case EMPTY = ""
    
}

enum OXGameState : String {
    
    case inProgress
    case complete_no_one_won
    case complete_someone_won
    
}

class OXGame {
    

    
    private var board = [CellType] (count : 9 , repeatedValue : CellType.EMPTY)
    
    private var startType : CellType = (CellType.X)
    
    
    //Build a function called turn() that returns an Int with the count of how many turns happened in the game so far.
    func turn() -> Int {
        
        var count : Int = 0
        
        for cell in board {
            if (cell != CellType.EMPTY){
                count += 1
            }
        }
        return count
        
    }
    
    //Create a function called whosTurn() that returns if it’s the CellType.O or CellType.X turn
    
    func whosTurn() -> CellType {
        
        if (turn() % 2 != 0){
            return CellType.X
        }
        return CellType.O
    }

    //Create a function that returns the CellType at a certain position of the board called typeAtIndex()
    func typeAtIndex(index : Int) -> CellType {
        
        if (board[index] == CellType.X) {
            return CellType.X
        } else if (board[index] == CellType.O) {
            return CellType.O
        }
        return CellType.EMPTY
    }
    //Create a function called playMove() that takes an Int as an input, updates the board, and returns the CellType of that move
    
    func playMove(tag : Int) -> CellType {

        if (whosTurn() == CellType.X) {
            
            board[tag] = CellType.X
            return CellType.X
            
        } else {
            
            board[tag] = CellType.O
            return CellType.O
            
        }
        
    }
    
    func winDetection() -> Bool {
    
    if (board[0] == CellType.X && board[1] == CellType.X && board[2] == CellType.X && board[2] != CellType.EMPTY) {
        return true
    }
    else if (board[3] == CellType.X && board[4] == CellType.X && board[5] == CellType.X && board[5] != CellType.EMPTY){
        return true
    }
    else if (board[6] == CellType.X && board[7] == CellType.X && board[8] == CellType.X && board[8] != CellType.EMPTY){
        return true
    }
    else if (board[0] == CellType.X && board[1] == CellType.X && board[2] == CellType.X && board[2] != CellType.EMPTY){
        return true
    }
    else if (board[3] == CellType.O && board[4] == CellType.O && board[5] == CellType.O && board[5] != CellType.EMPTY){
        return true
    }
    else if (board[6] == CellType.O && board[7] == CellType.O && board[8] == CellType.O && board[8] != CellType.EMPTY){
        return true
    }
    else if (board[0] == CellType.X && board[3] == CellType.X && board[6] == CellType.X && board[6] != CellType.EMPTY){
        return true
    }
    else if (board[1] == CellType.X && board[4] == CellType.X && board[7] == CellType.X && board[7] != CellType.EMPTY){
        return true
    }
    else if (board[2] == CellType.X && board[5] == CellType.X && board[8] == CellType.X && board[8] != CellType.EMPTY){
        return true
    }
    else if (board[0] == CellType.O && board[3] == CellType.O && board[6] == CellType.O && board[6] != CellType.EMPTY){
        return true
    }
    else if (board[1] == CellType.O && board[4] == CellType.O && board[7] == CellType.O && board[7] != CellType.EMPTY){
        return true
    }
    else if (board[2] == CellType.O && board[5] == CellType.O && board[8] == CellType.O && board[8] != CellType.EMPTY){
        return true
    }
    else {
        return false
    }
 
        /* Alternatively
 
            for i in 0...2 {
                if ((board[3*i] board[3*i + 1] etc... */
            }
    
    //    Create a variable from the win detection function to that contains if someone won at the current configuration of the board
    //    Use the variable to check if someone has won, if true, return the state complete_someone_won
    //    Else if (no one won) and it is turn 9, return complete_no_one_won
    //    Else return game still inProgress
    
    func state() -> OXGameState{
        
        if (winDetection() ) {
            return OXGameState.complete_someone_won
        } else if ((winDetection() == false) && (turn() == 8)) {
            return OXGameState.complete_no_one_won
        } else {
            return OXGameState.inProgress
        }
        
    }
    
    //Create a reset function called reset() that sets all the board cells to CellType.Empty
    func reset() {
        
        for (index, _) in board.enumerate(){ //iterator for loop in swift
            board[index] = .EMPTY //knows that board is a CellType array so it doesn't need to be told that again
        }
        
    }

    }
