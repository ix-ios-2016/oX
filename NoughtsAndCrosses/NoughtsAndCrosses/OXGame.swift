//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 5/30/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class OXGame {
   
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
    
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    
    private var startType:CellType = CellType.X
    
    func turn() -> Int {
        
        var count:Int = 0
        
        for cell in board {
           
            if cell != CellType.EMPTY {
                count += 1
                
            }

        
    
        }
        return count
    }
        

    func whosTurn() -> CellType {
        if (self.turn() % 2 == 0) {
            return .X
        } else {
            return .O
        }
        
    }
        //Create a function that returns the CellType at a certain position 
        //of the board called typeAtIndex()
    func typeAtIndex(tag:Int) -> CellType {
        return board[tag]
        }
    //Create a function called playMove() that takes an Int as an input, updates the board, and returns the CellType of that move
        func playMove(tag:Int) -> CellType {
            
            board[tag] = whosTurn()
            return board[tag]
        }
    func winDetection()-> Bool {
        
        if (typeAtIndex(0) == typeAtIndex(1)) && (typeAtIndex(1) == typeAtIndex(2) && (typeAtIndex(0) != CellType.EMPTY) ) {
            print("true1")
            return true
        }
        else if ((typeAtIndex(3) == typeAtIndex(4)) && (typeAtIndex(4) == typeAtIndex(5)) && (typeAtIndex(4) != CellType.EMPTY))  {
            print("true2")
            return true
        }
        else if ((typeAtIndex(6) == typeAtIndex(7)) && (typeAtIndex(7) == typeAtIndex(8)) && (typeAtIndex(8) != CellType.EMPTY))  {
            print("true3")
            return true
        }
        else if ((typeAtIndex(0) == typeAtIndex(3)) && (typeAtIndex(3) == typeAtIndex(6)) && (typeAtIndex(0) != CellType.EMPTY))  {
            print("true4")
            return true
        }
        else if ((typeAtIndex(1) == typeAtIndex(4)) && (typeAtIndex(4) == typeAtIndex(7)) && (typeAtIndex(4) != CellType.EMPTY))  {
            print("true5")
            return true
        }
        else if ((typeAtIndex(2) == typeAtIndex(5)) && (typeAtIndex(5) == typeAtIndex(8)) && (typeAtIndex(8) != CellType.EMPTY))  {
            print("true6")
            return true
        }
        else if ((typeAtIndex(0) == typeAtIndex(4)) && (typeAtIndex(4) == typeAtIndex(8)) && (typeAtIndex(0) != CellType.EMPTY))  {
            print("true7")
            return true
        }
        else if ((typeAtIndex(2) == typeAtIndex(4)) && (typeAtIndex(4) == typeAtIndex(6)) && (typeAtIndex(4) != CellType.EMPTY))  {
            print("true8")
            return true
        }
        
        else {
            print("false")
            return false
        }
    }
    
    func state() -> OXGameState {
        let winner = winDetection()
        if winner {
            print("The Loser is \(whosTurn())")
            let resultLabel = "The Loser is \(whosTurn())"
            return .complete_someone_won
        }
        else if self.turn() == 9 {
            print("No One Won")
            return .complete_no_one_won
        } else {
            print("in Progress")
            return .inProgress
        }
    }
    
    
    func reset(){
        board[0] = CellType.EMPTY
        board[1] = CellType.EMPTY
        board[2] = CellType.EMPTY
        board[3] = CellType.EMPTY
        board[4] = CellType.EMPTY
        board[5] = CellType.EMPTY
        board[6] = CellType.EMPTY
        board[7] = CellType.EMPTY
        board[8] = CellType.EMPTY
    }
    
}