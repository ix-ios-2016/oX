//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Rachel on 5/30/16.
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
    
    private var board = [CellType](count:9, repeatedValue: CellType.EMPTY)
    private var startType = CellType.X
    var currTurn = CellType.X
    
    //responsible for telling viewController whose turn it is
    
    private func turn() -> Int {
        
        var count = 0
        for cell in board {
            if cell != CellType.EMPTY {
                count = count + 1
            }
        }

        return count
    }
    
    func whosTurn() -> CellType {
        if (turn() % 2 == 0 ) {
            return CellType.O
        }
        else{
            return CellType.X
        }
    }
    //Create a function that returns the CellType at a certain position of the board called typeAtIndex()
    func typeAtIndex( index: Int ) -> CellType {
        return board[index]
    }
    
    //playMove() that takes an Int as an input, updates the board, and returns the CellType of that move.
    func playMove( i: Int ) -> CellType {
        board[i] = whosTurn()
        return whosTurn()
    }
    
    //    winDetection(). If you are running short of time (have less than 1 hour) ask us and we will provide you the code.
    //    Return true when some player won, false otherwise
    func winDetection() -> Bool {
        if ((typeAtIndex(0) == typeAtIndex(1)) && ( typeAtIndex(1) == typeAtIndex(2)) && (typeAtIndex(1) != CellType.EMPTY) )
        || ((typeAtIndex(3) == typeAtIndex(4)) && ( typeAtIndex(4) == typeAtIndex(5)) && (typeAtIndex(5) != CellType.EMPTY) )
        || ((typeAtIndex(6) == typeAtIndex(7)) && ( typeAtIndex(7) == typeAtIndex(8)) && (typeAtIndex(8) != CellType.EMPTY) )
        || ((typeAtIndex(0) == typeAtIndex(3)) && ( typeAtIndex(3) == typeAtIndex(6)) && (typeAtIndex(6) != CellType.EMPTY) )
        || ((typeAtIndex(1) == typeAtIndex(4)) && ( typeAtIndex(4) == typeAtIndex(7)) && (typeAtIndex(7) != CellType.EMPTY) )
        || ((typeAtIndex(2) == typeAtIndex(5)) && ( typeAtIndex(5) == typeAtIndex(8)) && (typeAtIndex(8) != CellType.EMPTY) )
        || ((typeAtIndex(0) == typeAtIndex(4)) && ( typeAtIndex(4) == typeAtIndex(8)) && (typeAtIndex(8) != CellType.EMPTY) )
        || ((typeAtIndex(2) == typeAtIndex(4)) && ( typeAtIndex(4) == typeAtIndex(6)) && (typeAtIndex(6) != CellType.EMPTY) )
        {
            
            return true
        }
        else {
        return false
        }
    }
    
//    Create a function called state() that returns the state of the game.
//    Create a variable from the win detection function to that contains if someone won at the current configuration of the board
//    Use the variable to check if someone has won, if true, return the state complete_someone_won
//    Else if (no one won) and it is turn 9, return complete_no_one_won
//    Else return game still inProgress
    
    func state() -> OXGameState {
        if ( winDetection() ){
            return OXGameState.complete_someone_won
        }
        else if ( (winDetection() == false) && (turn() == 8) ){
            return  OXGameState.complete_no_one_won
        }
        else {
            return OXGameState.inProgress
        }
        
    }
    
    //create a reset function called reset() that sets all the board cells to CellType.Empty
    func reset() {

        for ( index, _ ) in board.enumerate() {
            board[index] = CellType.EMPTY
        }
        //reset turn to X's
    }
    
    }













