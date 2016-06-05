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
    private var networkGame: Bool = false
    
    
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
    
    
    // return the current list of network games
    func getListOfGames() -> [OXGame]? {
        
        if (gameList?.count == 0) {
            let random: Int = Int(arc4random_uniform(UInt32(3)) + 2)
            
            for _ in 1...random {
                self.gameList?.append(OXGame())
            }
            
            for game in self.gameList! {
                game.gameId = getRandomID()
                game.hostUser = User(email:"hostuser@gmail.com", password: "")
            }
        }
        
        return gameList
    }
    
    
    // set the currentGame to be game
    private func setCurrentGame(game: OXGame) {
        currentGame = game
    }
    
    
    // access the currentGame, makes sure it isn't nil
    func getCurrentGame() -> OXGame? {
        
        if (currentGame == nil) {
            setCurrentGame(OXGame())
        }
        return currentGame
    }
    
    
    // Can only be called when there is an active game, plays move on specified cell
    func playMove(index: Int) -> CellType{
        
        let cellType: CellType = (currentGame?.playMove(index))!
        return cellType
        
    }
    
    
    // Simple random move, it will always try to play the first indexes
    func playRandomMove() -> (CellType, Int)? {
        
        if let count = currentGame?.board.count {
            for i in 0...count - 1 {
                if (currentGame?.board[i] == CellType.EMPTY){
                    let cellType: CellType = (currentGame?.playMove(i))!
                    return (cellType, i)
                }
            }
        }
        return nil
        
    }
    
    
    // create a new network game hosted by the logged_in_user
    func createNewGame(hostUser:User)   {
        print("Creating new network game")
        let game = OXGame()
        game.gameId = getRandomID()
        game.hostUser = hostUser
        gameList?.append(game)
    }
    
    
    // join existing network game
    func acceptGameWithId(gameId: String) -> OXGame? {
        
        for game in self.gameList!    {
            if (game.gameId == gameId)  {
                setCurrentGame(game)
                return game
            }
            
        }
        return nil
        
    }
    
    
    // close current game after it is over and remove from network
    func finishCurrentGame(){
        print("Finishing current game")
        
        if (gameList != nil && gameList?.count != 0) {
            var reducer = 0
            for i in 0...(gameList?.count)! - 1 {
                if (getCurrentGame()?.gameId == gameList![i - reducer].gameId) {
                    gameList?.removeAtIndex(i)
                    reducer += 1
                }
            }
        }
        
        setCurrentGame(OXGame())
    }
    
    
    // set networkGame boolean
    func setNetworkGame(network: Bool) {
        networkGame = network
    }
    
    
    //get networkGame boolean
    func getNetworkGame() -> Bool {
        return networkGame
    }
    
    
    // Helper functions
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