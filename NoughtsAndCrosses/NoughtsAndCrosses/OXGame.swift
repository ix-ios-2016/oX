//
//  OXGame.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation


enum CellType: String
{
    case EMPTY = ""
    case O = "O"
    case X = "X"
}


enum OXGameState: String
{
    case inProgress
    case complete_no_one_won
    case complete_someone_won
}



class OXGame
{
    
    private var board = [CellType](count: 9, repeatedValue: CellType.EMPTY)
    
    private var startType: CellType = CellType.X
    
    
    func turn() -> Int
    {
        var count = 0
        for cell in board
        {
            if (cell != CellType.EMPTY)
            {
                count += 1
            }
        }
        
        //print("There have been \(count) turns")
        
        return count
    }
    
    
    func whoseTurn() -> CellType
    {
        
        if (turn() % 2 == 0)
        {
            return CellType.X
        }
        else
        {
            return CellType.O
        }
    }
    
    
    func typeAtIndex(index: Int) -> CellType
    {
        
        return board[index]
    }
    
    
    func playMove(cell: Int) -> CellType
    {
        
        if (board[cell] == CellType.EMPTY)
        {
            let turn = whoseTurn()
            board[cell] = turn
            return turn
        }
        else
        {
            return CellType.EMPTY
        }
        
    }
    
    
    func winDetection() -> Bool
    {
        
        if (winHelp(0, dex2: 1, dex3: 2) ||
            winHelp(0, dex2: 3, dex3: 6) ||
            winHelp(0, dex2: 4, dex3: 8) ||
            winHelp(1, dex2: 4, dex3: 7) ||
            winHelp(2, dex2: 5, dex3: 8) ||
            winHelp(2, dex2: 4, dex3: 6) ||
            winHelp(3, dex2: 4, dex3: 5) ||
            winHelp(6, dex2: 7, dex3: 8))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func winHelp(dex1: Int, dex2: Int, dex3: Int) -> Bool
    {
        
        if (board[dex1] == board[dex2] &&
            board[dex2] == board[dex3] &&
            board[dex3] == board[dex1] &&
            board[dex1] != CellType.EMPTY)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func state() -> OXGameState
    {
        
        let winner = winDetection()
        if (winner)
        {
            return OXGameState.complete_someone_won
        }
        else if (turn() == 9)
        {
            return OXGameState.complete_no_one_won
        }
        else
        {
            return OXGameState.inProgress
        }
    }
    
    
    func reset()
    {
        
        var count = 0
        while count < 9 
        {
            board[count] = CellType.EMPTY
            count += 1
        }
    }
    
}

























