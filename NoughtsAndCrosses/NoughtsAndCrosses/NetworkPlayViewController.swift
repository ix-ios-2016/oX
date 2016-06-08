//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var gameList: [OXGame]?
    var refreshControl: UIRefreshControl!
    
    // set up table on load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Network Play"
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(NetworkPlayViewController.refreshTable), forControlEvents:
            UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func gameListReceived(games: [OXGame]?, message: String?) {
        
        
        if let games = games {
            self.gameList = games
            self.tableView.reloadData()
        }
        else if let _ = message {
            let alert = UIAlertController(title: "Error", message: "Unable load games, please try again!", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // refresh table and show navigation bar
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(games, message) in self.gameListReceived(games, message: message)})
        self.refreshTable()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // ensure games are all in the same section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Initialize number of rows in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gameList = gameList {
            return gameList.count
        }
        else {
            return 0
        }
    }
    
    
    // display available games
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(gameList![indexPath.row].gameId!): \(gameList![indexPath.row].hostUser!.email)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Games"
    }
    
    
    // control row selected action, navigate to game or show failure alert
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if gameList![indexPath.row].hostUser!.email != UserController.sharedInstance.logged_in_user!.email {
            OXGameController.sharedInstance.acceptGame(gameList![indexPath.row].gameId!, presentingViewController: self,viewControllerCompletionFunction: {(game, message) in self.acceptGameWithId(self.gameList![indexPath.row], message: message)})
        }
        else {
            let alert = UIAlertController(title: "Wrong Game", message: "You can't play yourself!", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
 
    func acceptGameWithId(game: OXGame?, message: String?) {

        if let _ = game {
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkGame = true
            self.navigationController?.pushViewController(bvc, animated: true)
        }
        else if let _ = message {
            let alert = UIAlertController(title: "Error", message: "Game unavailable, please refresh page", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }

    
    // create new game hosted by logged_in_user
    @IBAction func startGameButtonTapped(sender: UIButton) {
        for game in gameList! {
            if game.hostUser!.email == UserController.sharedInstance.logged_in_user!.email {
                let alert = UIAlertController(title: "Failure", message: "You can only host one game at a time!", preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(closeAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
        }
        //let game = OXGameController.sharedInstance.createGameWithHostUser(UserController.sharedInstance.logged_in_user!.email)
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.logged_in_user!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.createGame(game, message: message)})
    }
    
    
    func createGame(game: OXGame?, message: String?) {
        
        if let _ = game {
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkGame = true
            self.navigationController?.pushViewController(bvc, animated: true)
        }
        else if let _ = message {
            let alert = UIAlertController(title: "Error", message: "Unable to create game, please try again!", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    // refresh table of available games
    func refreshTable() {
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message: message)})
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}
