//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-06-03.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var networkTable: UITableView!
    var gameList: [OXGame]?
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instantiate the table
        self.title = "Choose a Game"
        self.networkTable.dataSource = self
        self.networkTable.delegate = self
//        self.gameList = OXGameController.sharedInstance.getListOfGames()
        
        // set up refresher controller
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(NetworkPlayViewController.refreshTable),
                                 forControlEvents: UIControlEvents.ValueChanged)
        networkTable.addSubview(refreshControl)
    }
    
    func refreshTable() {
//        self.gameList = OXGameController.sharedInstance.getListOfGames()
        self.networkTable.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message:message)})
        
    }
    
    func gameListReceived(games:[OXGame]?, message: String?) {
//        print("games received \(games)")
        if let newGames = games {
            self.gameList = newGames
        }
        self.networkTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide navigation bar
        self.navigationController?.navigationBarHidden = false
        
        // refresh table
//        self.gameList = OXGameController.sharedInstance.getListOfGames()
        self.networkTable.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        OXGameController.sharedInstance.acceptGame(self.gameList![indexPath.row].gameId!, presentingViewController: self, viewControllerCompletionFunction: {(gameList, message) in self.acceptGameComplete(gameList, message: message)})
        
    }
    
    func acceptGameComplete(game: OXGame?, message: String?) {
        print("accept game complete")
        
        if let gameAcceptedSuccess = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkGame = true
            networkBoardView.currentGame = gameAcceptedSuccess
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = self.gameList?.count {
            return rows
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =
            "ID: \(self.gameList![indexPath.row].gameId!), Email: \(self.gameList![indexPath.row].hostUser!.email)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
//        OXGameController.sharedInstance.createNewGame(user)
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.newGameCompleted(game, message:message)})
        
    }
    
    func newGameCompleted(game: OXGame?, message:String?) {
        if let newGame = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkGame = true
            networkBoardView.currentGame = newGame
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }

}
