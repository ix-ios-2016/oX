//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var gamesList : [OXGame] = []
    @IBOutlet weak var createNewGameInNetworkMode: UIButton!
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Network Play"
        // Do any additional setup after loading the view.
        
        gamesList = OXGameController.sharedInstance.getListOfGames()!
        
        //Setting the controller as the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
//        let gameOne = OXGame()
//        let gameTwo = OXGame()
//        let gameThree = OXGame()
//        
//        gamesList.append(gameOne)
//        gamesList.append(gameTwo)
//        gamesList.append(gameThree)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        }

    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func createNewNetworkGame(sender: UIButton) {
    }
    
    func refreshTable() {
        self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row \(indexPath.row)")
        
        OXGameController.sharedInstance.acceptGameWithId(gamesList[indexPath.row].gameId!)
        let networkGameBVC = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.navigationController?.pushViewController(networkGameBVC, animated: true)
        networkGameBVC.networkGame = true
        
        //So that the gameList data updates upon refresh
        self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
      return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (gamesList.count != 0){
            return gamesList.count
        } else {
            return 0
            
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var game = OXGameController.sharedInstance //if we didn't have sharedInstance() the variable would be empty
        cell.textLabel?.text =  (game.getListOfGames()![indexPath.row].gameId)! + " " + game.getListOfGames()![indexPath.row].hostUser!.email //the getListOfGames() method returns an array so you can basically think of it as an array
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
