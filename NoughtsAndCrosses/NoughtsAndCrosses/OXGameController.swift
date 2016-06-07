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
    
    
    
    /**
    
    func registerUser(email:String, password:String, presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:(User?,String?) -> ()) {
       
        
     
        let user = ["email":email,"password":password]
        
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, int and JSON.
            //int is the response code from the server.
            //JSON is the response data received
            
            print( json)
            var user:User = User(email: "", password: "",token:"", client: "")
            
            
            if (responseCode / 100 == 2)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored",token:json["data"]["token"].stringValue,client:"||")
                
                //we need to get our user security token out of the request's header (remember from Postman, we need those values when making in app calls)
                
                
                
                
                //Persist
                self.storeUser(user)
                self.setLoggedInUser(user)
                self.logged_in_user = user
                
                //Note that our registerUser function 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                viewControllerCompletionFunction(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                viewControllerCompletionFunction(nil,errorMessage)
            }
            
            
            //Not that our registerUser function 4 parameters: email, password, presentingViewController and completion
            //completion is a closure for what is to happen in the ViewController when we are done with the webservice.
            //lets go back to that closure now
            viewControllerCompletionFunction(user,nil)
        })
        
        //we are now done with the registerUser function. Note that this function doesnt return anything. But because of the viewControllerCompletionFunction closure we are given as an input parameter, we can set in motion a function in the calling class when it is needed.
        
 
        
    }
    
     */

    
    
    
//        func getListOfGames() -> [OXGame]? {
//    //        print("Getting list of games")
//    
//            if(gameList?.count == 0){
//    
//                let random: Int = Int(arc4random_uniform(UInt32(3)) + 2)
//                //Create games
//                for _ in 1...random {
//                    self.gameList?.append(createGameWithHostUser("hostuser@gmail.com"))
//    
//                }
//    
//            }
//    
//            return gameList
//    
//        }
    
    func gameList(presentingViewController:UIViewController? = nil, viewControllerCompletionFunction:([OXGame]?,String?) -> ()) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        self.executeRequest(request, presentingViewController:presentingViewController, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            print(responseCode)
            
            if (responseCode / 100 == 2)   {
                
                
                //User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored",token:json["data"]["token"].stringValue,client:"||")
                
                
                //Persist
                    /**
                self.storeUser(user)
                self.setLoggedInUser(user)
                self.logged_in_user = user
 */
                
                //Note that our registerUser function 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                
                //viewControllerCompletionFunction(user,nil)
                
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
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
        game.gameID = getRandomID()
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