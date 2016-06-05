//
//  OXGameController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 6/2/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

class OXGameController {
    
    var gameList:[OXGame]? = []
    private var currentGame: OXGame?
    
    
    class var sharedInstance: OXGameController {
        struct Static {
            static var instance:OXGameController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = OXGameController()
        }
        return Static.instance!
        
    }
    
    func getListOfGames() -> [OXGame]? {
        //        print("Getting list of games")
        
        if(gameList?.count == 0){
            
            let random: Int = Int(arc4random_uniform(UInt32(3)) + 2)
            //Create games
            for _ in 1...random {
                self.gameList?.append(OXGame())
            }
            
            for game in self.gameList! {
                game.gameId = getRandomID()
                game.hostUser = User(email:"hostuser@gmail.com",password: "")
            }
            
        }
        
        return gameList
    }
    
    func getCurrentGame() -> OXGame? {
        //        print("Getting current game")
        return currentGame
    }
    
    
    //Can only be called when there is an active game
    func playMove(index: Int) -> CellType{
        //        print("PlayingMove on 'network'")
        let cellType: CellType = (currentGame?.playMove(index))!
        return cellType
    }
    
    //Simple random move, it will always try to play the first indexes
    func playRandomMove() -> (CellType, Int)? {
        //        print("Playing random move")
        if let count = currentGame?.board.count {
            for i in 0...count - 1 {
                if (currentGame?.board[i] == CellType.EMPTY){
                    let cellType: CellType = (currentGame?.playMove(i))!
                    //                    print(cellType)
                    //                    print("Succesfully at: " + String(i))
                    return (cellType, i)
                }
            }
        }
        //        print("Unsuccesfully")
        return nil
        
    }
    
    func createNewGame(hostUser:User)   {
        print("Creating new network game")
    }
    
    
    func acceptGameNumber(gameId: String) -> OXGame? {
        //        print("Accepting network game")
        for game in self.gameList!    {
            if (game.gameId == gameId)  {
                currentGame = game
                //                print("Succesfully")
                return game
            }
            
        }
        //        print("Not succesfully")
        return nil
    }
    
    func finishCurrentGame(){
        //        print("Finishing current game")
        //Delete from game array and setting currentGame to nil
        //        print(getCurrentGame()?.gameId)
        for i in 0...(gameList?.count)! - 1{
            if (getCurrentGame()?.gameId == gameList![i].gameId){
                currentGame = nil
                gameList?.removeAtIndex(i)
                return
            }
        }
        
    }
    
    //Helper functions
    func getRandomID() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len: Int = 10
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 1...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString as String
    }
    
}