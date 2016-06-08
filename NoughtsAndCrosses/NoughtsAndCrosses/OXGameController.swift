
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
    
    //Called when an user in an active game want to end the game before its finished
    func cancelGame(gameId:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(Bool,String?) -> ()) {
        
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "DELETE", parameters: user)
        
        //execute request is a function we are able to call in OXGameController, because OXGameController extends WebService (See top of file, where OXGameController is defined)
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            if (responseCode / 100 == 2)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                //successfully deleted the game, no data to return needed
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                self.finishCurrentGame()
                viewControllerCompletionFunction(true,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(false, errorMessage)
            }
            
        })
        
        //we are now done with the registerUser function. Note that this function doesnt return anything. But because of the viewControllerCompletionFunction closure we are given as an input parameter, we can set in motion a function in the calling class when it is needed.
        
    }
    
    func gameList(presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:([OXGame]?,String?) -> ()) {
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: user)
        
        self.executeRequest(request, presentingViewController: presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            //print(json)
            //print(UserController.sharedInstance.logged_in_user?.client)
            //print(UserController.sharedInstance.logged_in_user?.token)
            var gameList: [OXGame] = []
            if (responseCode / 100) == 2 {
                for (_, game) in json {
                    gameList.append(OXGame(json: game))
                }
                
                viewControllerCompletionFunction(gameList, nil)
            }
            else {
                
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
    func playMove(board: String, gameId:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ())  {
        
        
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        
        let params = ["board":board,"email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "PUT", parameters: params)
        
        //execute request is a function we are able to call in OXGameController, because OXGameController extends WebService (See top of file, where OXGameController is defined)
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            
            if (responseCode / 100 == 2)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                let game = OXGame(json: json)
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                viewControllerCompletionFunction(game,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil, errorMessage)
            }
            
        })
        
        //we are now done with the registerUser function. Note that this function doesnt return anything. But because of the viewControllerCompletionFunction closure we are given as an input parameter, we can set in motion a function in the calling class when it is needed.
        
        
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
    
    
    func getGame(id: String, presentingViewController: UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ()) {
        
        print("fuckkk")
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "GET", parameters: user)
        
        self.executeRequest(request, presentingViewController: presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100) == 2 {
                self.setCurrentGame(OXGame(json: json))
                viewControllerCompletionFunction(OXGame(json: json), nil)
            }
            else {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                viewControllerCompletionFunction(nil,errorMessage)
                
            }
        })
        
    }
    
    
    func createNewGame(host:User, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ())   {
        print("Creating new network game")
        
        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: user)
        
        self.executeRequest(request, presentingViewController: presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100) == 2 {
                self.setCurrentGame(OXGame(json: json))
                viewControllerCompletionFunction(OXGame(json: json), nil)
            }
            else {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                viewControllerCompletionFunction(nil,errorMessage)
                
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
    
    
    func acceptGame(id:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(OXGame?,String?) -> ()) {

        let user: Dictionary<String, String> = ["email":(UserController.sharedInstance.logged_in_user?.email)!,"password":(UserController.sharedInstance.logged_in_user?.password)!, "token":(UserController.sharedInstance.logged_in_user?.token)!, "client":(UserController.sharedInstance.logged_in_user?.client)!]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)/join"), method: "GET", parameters: user)
        
        self.executeRequest(request, presentingViewController: presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100) == 2 {
                self.setCurrentGame(OXGame(json: json))
                viewControllerCompletionFunction(OXGame(json: json), nil)
            }
            else {
                
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



