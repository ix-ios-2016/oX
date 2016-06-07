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
    
    
    
    // this function returns a array of OXGAmes available from the web. if the webs service fails for some reason it returns nil for the OXGame array, and a message instead to show the user for reason of failure
    func gameList(presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:([OXGame]?,String?) -> ()) {
        
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        //execute request is a function we are able to call in OXGameController, because OXGameController extends WebService (See top of file, where OXGameController is defined)
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            print(json)
            
            if (responseCode / 100 == 2)
            { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                //successfully received the game list
                var list:[OXGame]? = []
                
                //lets populate the list var with the game data received
                for (str, game) in json    {
                    var game = OXGame(json: game)
                    if (game.backendState == OXGameState.open)
                    {
                        list?.append(game)
                    }
                    
                }
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                viewControllerCompletionFunction(list,nil)
            }
            else
            {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
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
    
    func playNetworkMove(board: String, gameId: String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?, String?) -> ())
    {
        
        let params = ["board": board]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "PUT", parameters: params)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2)
            {
                let game = OXGame(json: json)
                self.setCurrentGame(game)
                viewControllerCompletionFunction(game, nil)
            }
            else
            {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
            }
        })
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
    
    func createNewGame(host:User, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ())
    {
        print("Creating new network game")
        
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "POST", parameters: nil)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2)
            {
                let game: OXGame = OXGame(json: json)
                self.setCurrentGame(game)
                viewControllerCompletionFunction(game,nil)
            }
            else
            {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
            }
            
        })

        
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
    
    
    func acceptGame(id:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ())
    {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com//games/\(id)/join"), method: "GET", parameters: nil)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2)
            {
                let game: OXGame = OXGame(json: json)
                self.setCurrentGame(game)
                viewControllerCompletionFunction(game,nil)
            }
            else
            {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
            }
            
        })
        
        
    }
    
    
    func getGame(id:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?, String?) -> ())
    {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com//games/\(id)"), method: "GET", parameters: nil)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2)
            {
                let game: OXGame = OXGame(json: json)
                
                self.setCurrentGame(game)
                
                viewControllerCompletionFunction(game, nil)
            }
            else
            {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
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