//
//  OXGameController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 6/2/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit
import Foundation

class OXGameController: WebService {
    
    var gameList:[OXGame]? = []
    
    
    private var currentGame: OXGame = OXGame()
    // create a network game mode boolean
    var networkMode:Bool = false
    
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
    
    func getListOfGames(presentingViewController:UIViewController? = nil) -> [OXGame]?
    {
        let request = self.createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        self.executeRequest(request, presentingViewController: presentingViewController, requestCompletionFunction:
            {(responseCode, json) in
                
                // successful response code
                if (responseCode / 100 == 2)
                {
                    self.gameList = json
                }
                
                
        })
        
        
        
        //        if(gameList?.count == 0)
        //        {
        //            let random: Int = Int(arc4random_uniform(UInt32(3)) + 2)
        //            //Create games
        //            for _ in 1...random {
        //                self.gameList?.append(OXGame())
        //            }
        //
        //            for game in self.gameList! {
        //                game.gameId = getRandomID()
        //                //game.hostUser = User(email:"hostuser@gmail.com",password: "")
        //            }
        //        }
        //
        //        return gameList
    }
    
    func setCurrentGame(game: OXGame){
        currentGame = game
    }
    
    func getCurrentGame() -> OXGame? {
        //        print("Getting current game")
        
        //if(currentGame == nil) {
        //            setCurrentGame(OXGame())
        //}
        
        return currentGame
    }
    
    
    //Can only be called when there is an active game
    func playMove(index: Int) -> CellType{
        //        print("PlayingMove on 'network'")
        let cellType: CellType = currentGame.playMove(index)
        return cellType
    }
    
    //Simple random move, it will always try to play the first indexes
    func playRandomMove() -> (CellType, Int)?
    {
        //        print("Playing random move")
        let count = currentGame.board.count
        for i in 0...count - 1 {
            if (currentGame.board[i] == CellType.EMPTY){
                let cellType: CellType = (currentGame.playMove(i))
                
                print(cellType)
                print("Succesfully at: " + String(i))
                
                return (cellType, i)
            }
        }
        
        //        print("Unsuccesfully")
        return nil
        
    }
    
    // used to have this as parameter: hostUser:User. I changed it
    func createNewGame(hostUser:User)   {
        print("Creating new network game")
        
        let newGame = OXGame()
        newGame.gameId = getRandomID()
        newGame.hostUser = hostUser
        
        gameList?.append(newGame)
    }
    
    func acceptGameWithId(gameId: String) -> OXGame? {
        //        print("Accepting network game")
        for game in self.gameList!    {
            if (game.gameId == gameId)  {
                setCurrentGame(game)
                //                print("Succesfully")
                return game
            }
            
        }
        //        print("Not succesfully")
        return nil
    }
    
    func finishCurrentGame(){
        print("Finishing current game")
        
        if let game = self.getCurrentGame() {
            game.reset()
        }
        
        if networkMode
        {
            // get rid of the current game from the gameList
            if(gameList != nil && gameList?.count != 0){
                var reducer = 0
                
                print("PreGames LIST: ")
                for game in gameList!
                {
                    print(game.gameId)
                }
                
                for i in 0..<(gameList?.count)!
                {
                    
                    if (getCurrentGame()?.gameId == gameList![i - reducer].gameId)
                    {
                        print("Actual Game: " + String(getCurrentGame()?.gameId ))
                        print("In the list: " + String(gameList![i - reducer].gameId))
                        
                        
                        gameList?.removeAtIndex(i)
                        reducer += 1
                        
                        print("POSTGames LIST: ")
                        for game in gameList!
                        {
                            print(game.gameId)
                        }
                    }
                }
            }
        }
        
        setCurrentGame(OXGame())
    }
    
    
    
    //Create a getter and setter for this networkMode.
    func getNetworkMode() -> Bool {
        return networkMode
    }
    func setNetworkMode(value:Bool) {
        networkMode = value
    }
    
    //Helper functions
    private func getRandomID() -> String {
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