//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Rachel on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//


//In the delegate method that returns the cell for an index, get the game in the gamesList at the given index, and display the email of the hostUser of the game in the cell.

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var networkGameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var gameList = [OXGame]()
    var refreshControl: UIRefreshControl!
    
//    override func viewDidAppear(animated: Bool) {
//        self.title = "Network Play"
//        self.navigationController?.navigationBarHidden = false
//        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message: message )})
//    }
    
    func gameListReceived( games: [OXGame]?, message: String?){
        
        print("games received \(games!)")
        if let newGames = games {
            self.gameList = newGames
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Play"
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(NetworkPlayViewController.refreshTable), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)


    }
    func refreshTable(){
        
        OXGameController.sharedInstance.gameList( self, viewControllerCompletionFunction: {(gameList , message) in self.getListOfGamesCompletion(gameList, message: message )})
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Network Play"
        
        self.navigationController?.navigationBarHidden = false
         OXGameController.sharedInstance.gameList( self, viewControllerCompletionFunction: {(gameList , message) in self.getListOfGamesCompletion(gameList, message: message )})
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()

    }
    
    func getListOfGamesCompletion(gameList: [OXGame]?, message: String?){
        if let newGames = gameList {
            self.gameList = newGames
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of games in the gamesList if it is set, if it is not set, return 0.
        if  ( gameList.count > 0 ){
            return gameList.count
        }
        
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //return a cell with it’s textLabel’s text property set to “test cell label”
        
        let cell = UITableViewCell()
        
        //cell.backgroundColor = UIColor.redColor()
        //get the game in the gamesList at the given index, and display the email of the hostUser of the game in the cell.
        cell.textLabel?.text = "gameID: " + self.gameList[indexPath.row].gameID! + ", " + self.gameList[indexPath.row].hostUser!.email
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Network Games"
    }

    
    //push a new board view onto the existing navigation. This involves, instantiating and then pushing the view.

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let gameRowSelected = indexPath.row
        let gameSelected = gameList[gameRowSelected]
        
        OXGameController.sharedInstance.acceptGame(gameSelected.gameID!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game,message:message)})
    }
    
    func acceptGameComplete( game: OXGame!, message: String! ){
        if let gameAcceptedSuccess = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil )
            networkBoardView.networkMode = true
            networkBoardView.currentGame = gameAcceptedSuccess
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }
    
    
    @IBAction func networkGameButtonTapped(sender: UIButton) {
        
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.newStartGameCompleted(game,message:message)})
    }
    
    func newStartGameCompleted(game: OXGame!, message: String!){
        if let newGame = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil )
            networkBoardView.networkMode = true
            networkBoardView.currentGame = newGame
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
        
    }

    
    
    

}
