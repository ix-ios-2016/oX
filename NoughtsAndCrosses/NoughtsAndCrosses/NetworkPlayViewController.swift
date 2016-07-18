//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ryan Davey on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var gamesList: [OXGame] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gamesList = OXGameController.sharedInstance.getListOfGames()!
        
        self.title = "Network Play"
        networkTableView.delegate = self
        networkTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        networkTableView.addSubview(refreshControl)
    }

    func refreshTable () {
       //self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        networkTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var networkTableView: UITableView!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var gameRowSelected = self.gamesList[indexPath.row]
        
        
        OXGameController.sharedInstance.acceptGame(gameRowSelected.gameId!,presentingViewController: self,viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game,message:message)})
        print("did select row \(indexPath.row)")
    }
    
    func acceptGameComplete(game:OXGame?, message:String?) {
        if let acceptGameSuccess = game {
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkGame = true
            bvc.currentGame = acceptGameSuccess
            self.navigationController?.pushViewController(bvc, animated: true)        }
    }
    
    @IBAction func networkGameTapped(sender: UIButton) {
        print("networkGameButtonTapped")
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game,message) in self.newStartGameCompleted(game, message:message)})
    }
    
    func newStartGameCompleted(game:OXGame?,message:String?) {
        if let newGame = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkGame = true
            networkBoardView.currentGame = newGame
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\((gamesList[indexPath.row].gameId)!)" + "   " + "\((gamesList[indexPath.row].hostUser)!)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    
    func gameListReceived(games:[OXGame]?,message:String?) {
        print ("games received")
        if let newGames = games {
            self.gamesList = newGames
        }
        self.networkTableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
       // self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        OXGameController.sharedInstance.gameList(self,viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message:message)})
        
        self.networkTableView.reloadData()
    }
}
