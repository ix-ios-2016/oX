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
    
    var board = [CellType] (count : 9 , repeatedValue : CellType.EMPTY)
    
    private var startType : CellType = (CellType.X)
    
    var hostUser : User?
    var guestUser : User?
    var backendState : OXGameState?
    var gameId : String?
    
    
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
            return startType
        } else {
            return CellType.O
        }
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
            
            board[tag] = (CellType.X)
            print (board[tag])
            return CellType.X
            
        } else {
            
            board[tag] = CellType.O
            print (board[tag])
            return CellType.O
            
        }
        
    }
    
    func winDetection() -> Bool {
    
        //Check rows
        for i in 0...2 {
            if((board[3*i] == board[3*i + 1]) && (board[3*i] == board[3*i + 2]) && !(String(board[3*i]) == "EMPTY")){
                print("Someone won at row i")
                print(i)
                print( board[i])
                return true
            }
        }
        
        //Check columns
        for j in 0...2 {
            if((board[j] == board[j + 3]) && (board[j] == board[j + 6]) && !(String(board[j]) == "EMPTY")){
                print("Someone won at column j")
                print(j)
                print( board[j])
                return true
            }
        }
        
        //Check diagonals
        if((board[0] == board[4]) && (board[0] == board[8]) && !(String(board[0]) == "EMPTY")){
            print("Someone won at diagonal 1")
            return true
        }
        if((board[2] == board[4]) && (board[2] == board[6]) && !(String(board[2]) == "EMPTY")){
            print("Someone won at diagonal 2")
            return true
        }
        
        return false
        
    }
    //the current state of the game
    func state() -> OXGameState    {
        
        //check if someone won on this turn
        let win = winDetection()
        
        //if noone won, game is still in progress
        if (win)   {
            return OXGameState.complete_someone_won
        } else if (turn() == 9) {
            return OXGameState.complete_no_one_won
        } else    {
            return OXGameState.inProgress
        }
        
    }
 
        /* Alternatively
 
            for i in 0...2 {
                if ((board[3*i] board[3*i + 1] etc... */
    
    //    Create a variable from the win detection function to that contains if someone won at the current configuration of the board
    //    Use the variable to check if someone has won, if true, return the state complete_someone_won
    //    Else if (no one won) and it is turn 9, return complete_no_one_won
    //    Else return game still inProgress

    //Create a reset function called reset() that sets all the board cells to CellType.Empty
    func reset() {
        
        for (index, _) in board.enumerate(){ //iterator for loop in swift
            board[index] = .EMPTY //knows that board is a CellType array so it doesn't need to be told that again
        }
        
    }

}
