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
        
        OXGameController.sharedInstance.gameList(self,viewControllerCompletionFunction: {(gameList,message) in self.gameListFetchComplete(gameList, message: message)})
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
    
    
    func gameListFetchComplete(list : [OXGame]? , message : String?) {
        
        if let validList = list {
            self.gamesList = validList
        }
        self.tableView.reloadData()
        
    }
    
    func refreshTable() {
        //Closure call goes here
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row \(indexPath.row)")
        
        //OXGameController.sharedInstance.acceptGameWithId(gamesList[indexPath.row].gameId!)
        //Closure call goes here

        let networkGameBVC = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.navigationController?.pushViewController(networkGameBVC, animated: true)
        networkGameBVC.networkGame = true
        
        //So that the gameList data updates upon refresh
        //Closure call goes here
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
        
        //Closure call goes here
        cell.textLabel?.text = self.gamesList[indexPath.row].hostUser!.email
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
