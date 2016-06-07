//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/05/09.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import SwiftyJSON


enum CellType : String {
    
    case O = "O"
    case X = "X"
    case EMPTY = ""
    
}

enum OXGameState : String {
    
    case inProgress
    case complete_no_one_won
    case complete_someone_won
    case open
    
    
}

class OXGame    {
    
    //the board data, stored in a 1D array
    
    var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    //the type of O or X that plays first
    private var startType:CellType = CellType.X
    
    var gameId: String?
    var hostUser: User?
    var guestUser: User?
    var backendState: OXGameState?
    
    //default constructor
    init()  {
        
    }
    
    //constructor from JSON
    init(json:JSON)  {
        //        print("json init")
        self.gameId = json["id"].stringValue
        self.backendState = OXGameState(rawValue: json["state"].stringValue)
        self.board = deserialiseBoard(json["board"].stringValue)
        self.hostUser = User(json:json["host_user"])
        self.guestUser = User(json:json["guest_user"])
        
    }
    
    func serialiseBoard() -> String  {
        
        var resultBoard = ""
        for cell in self.board  {
            if (cell == CellType.EMPTY) {
                resultBoard = resultBoard + "_"
            }   else if (cell == CellType.O)  {
                resultBoard = resultBoard + "o"
            }   else    {
                resultBoard = resultBoard + "x"
            }
        }
        
        return resultBoard
    }
    
    private func deserialiseBoard(boardString:String) -> [CellType] {
        
        var newBoard:[CellType] = []
        for (index, char) in boardString.characters.enumerate() {
            print (char)
            
            if (char == "_")   {
                //EMPTY
                newBoard.append(CellType.EMPTY)
            }   else if (char == "x")  {
                newBoard.append(CellType.X)
            }   else if (char == "o")  {
                newBoard.append(CellType.O)
            }
        }
        return newBoard
    }
    
    
    
    //returns the number of turns the players have had on the board
    private func turn() -> Int {
        return board.filter{(pos) in (pos != CellType.EMPTY)}.count
    }
    
    //returns if its X or O's turn to play
    func whosTurn()  -> CellType {
        let count = turn()
        if (count % 2 == 0)   {
            return startType
        }   else    {
            
            if (startType == CellType.X)    {
                return CellType.O
            }   else    {
                return CellType.X
            }
        }
        
    }
    
    //returns user type at a specific board index
    func typeAtIndex(pos:Int) -> CellType! {
        return board[pos]
    }
    
    //one of the later functions created in the demo
    //execute the move in the game
    func playMove(position:Int) -> CellType! {
        board[position] = whosTurn()
        return board[position]
    }
    
    func winDetection() -> Bool {
        
        //Check rows
        for i in 0...2 {
            if((board[3*i] == board[3*i + 1]) && (board[3*i] == board[3*i + 2]) && !(String(board[3*i]) == "EMPTY")){
                //                print("Someone won at row i")
                //                print(i)
                //                print( board[i])
                return true
            }
        }
        
        //Check columns
        for j in 0...2 {
            if((board[j] == board[j + 3]) && (board[j] == board[j + 6]) && !(String(board[j]) == "EMPTY")){
                //                print("Someone won at column j")
                //                print(j)
                //                print( board[j])
                return true
            }
        }
        
        //Check diagonals
        if((board[0] == board[4]) && (board[0] == board[8]) && !(String(board[0]) == "EMPTY")){
            //            print("Someone won at diagonal 1")
            return true
        }
        if((board[2] == board[4]) && (board[2] == board[6]) && !(String(board[2]) == "EMPTY")){
            //            print("Someone won at diagonal 2")
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
    
    //restart the game
    func reset()    {
        board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
        //        print("Reseting")
    }
    
    
}