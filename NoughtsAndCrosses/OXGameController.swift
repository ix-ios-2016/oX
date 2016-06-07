//
//  OXGameController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 6/2/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class OXGameController: WebService {
    
    //    var gameList:[OXGame]? = []
    private var currentGame: OXGame = OXGame()
    
    
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
    
    //    func getListOfGames() -> [OXGame]? {
    ////        print("Getting list of games")
    //
    //        if(gameList?.count == 0){
    //
    //            let random: Int = Int(arc4random_uniform(UInt32(3)) + 2)
    //            //Create games
    //            for _ in 1...random {
    //                self.gameList?.append(createGameWithHostUser("hostuser@gmail.com"))
    //
    //            }
    //
    //        }
    //
    //        return gameList
    //
    //    }
    
    func gameList(presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:([OXGame]?,String?) -> ()) {
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!, "token": (UserController.sharedInstance.logged_in_user?.token)!, "client": (UserController.sharedInstance.logged_in_user?.client)!]
        print(UserController.sharedInstance.logged_in_user)
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: user)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print( json)
            print(responseCode)
            
            if (responseCode / 100 == 2)   {
                
                //successfully received the game list
                var list:[OXGame]? = []
                
                //lets populate the list var with the game data received
                for (str, game) in json    {
                    var game = OXGame(json: game)
                    if (game.backendState == OXGameState.open)   {
                        list?.append(game)
                    }
                    
                }
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                viewControllerCompletionFunction(list,nil)
            
            }   else    {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                viewControllerCompletionFunction(nil,errorMessage)
            }
            
            
        })

        
    }
    
    
    
    private func setCurrentGame(game: OXGame){
        currentGame = game
    }
    
    func getCurrentGame() -> OXGame? {
        //        print("Getting current game")
        
        return currentGame
    }
    
    func createGameWithHostUser(hostEmail: String) -> OXGame {
        
        let game = OXGame()
        game.gameId = getRandomID()
        game.hostUser = User(email:hostEmail,password: "",token:"",client:"")
        return game
        
    }
    
    
    //Can only be called when there is an active game
    func playMove(index: Int) -> CellType{
        //        print("PlayingMove on 'network'")
        
        let cellType: CellType = currentGame.playMove(index)
        return cellType
    }
    
    //Simple random move, it will always try to play the first indexes
    func playRandomMove() -> (CellType, Int)? {
        //        print("Playing random move")
        
        for i in 0...currentGame.board.count - 1 {
            if (currentGame.board[i] == CellType.EMPTY){
                let cellType: CellType = (currentGame.playMove(i))!
                //                    print(cellType)
                //                    print("Succesfully at: " + String(i))
                return (cellType, i)
            }
        }
        //        print("Unsuccesfully")
        return nil
        
    }
    
    func createNewGame(host:User, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ())   {
        print("Creating new network game")
        
    }
    
    
    //    func acceptGameWithId(gameId: String) -> OXGame? {
    ////        print("Accepting network game")
    //        for game in self.gameList!    {
    //            if (game.gameId == gameId)  {
    //                setCurrentGame(game)
    ////                print("Succesfully")
    //                return game
    //            }
    //
    //        }
    ////        print("Not succesfully")
    //        return nil
    //    }
    
    
    func acceptGame(id:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ()) {
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!, "token": (UserController.sharedInstance.logged_in_user?.token)!, "client": (UserController.sharedInstance.logged_in_user?.client)!]
        print(UserController.sharedInstance.logged_in_user)
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/{{game_id}}/join"), method: "GET", parameters: user)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print( json)
            print(responseCode)
            
            if (responseCode / 100 == 2)   {
                
                var gameID = json["data"]["id"]
                
                
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
              //  viewControllerCompletionFunction(gameID ,nil)
                
            }   else    {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                viewControllerCompletionFunction(nil,errorMessage)
            }
            
            
        })

        
    }
    
    func finishCurrentGame(){
        print("Finishing current game")
        
        //        if(gameList != nil && gameList?.count != 0){
        //            var reducer = 0
        //            for i in 0...(gameList?.count)! - 1{
        //                if (getCurrentGame()?.gameId == gameList![i - reducer].gameId){
        //                    gameList?.removeAtIndex(i)
        //                    reducer += 1
        //                }
        //            }
        //        }
        //
        currentGame.reset()
        
        setCurrentGame(OXGame())
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