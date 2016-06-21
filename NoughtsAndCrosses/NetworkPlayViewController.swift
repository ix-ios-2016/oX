//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var gameTable: UITableView!
    @IBOutlet weak var gameButton: UIButton!
    var gameList : [OXGame]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
        OXGameController.sharedInstance.gameList.self(viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message:message)})
        gameTable.dataSource = self
        gameTable.delegate = self
    }
    
    func gameListReceived(games: [OXGame]?, message:String?) {
        if let newGames = games {
            self.gameList = newGames
        }
        self.gameTable.reloadData()
    }

    @IBAction func gameButtonTapped(sender: AnyObject) {
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.newStartGameComplete(game, message:message)})
    }
    
    func newStartGameComplete(game:OXGame?, message:String?) {
        if let newGame = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkMode = true
            networkBoardView.currentGame = newGame
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        OXGameController.sharedInstance.acceptGame(self.gameList![indexPath.row].gameId!,presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game, message: message)})
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = gameList![indexPath.row].hostUser!.email
        cell.textLabel?.text = user
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }

    func acceptGameComplete(game:OXGame?, message:String?) {
        if let gameAcceptedSuccess = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkMode = true
            networkBoardView.currentGame = gameAcceptedSuccess
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }
    
}
