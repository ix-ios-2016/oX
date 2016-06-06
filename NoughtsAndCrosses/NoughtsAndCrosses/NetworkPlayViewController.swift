//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Joe Salter on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gamesList: [OXGame] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        self.title = "Network Play"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(NetworkPlayViewController.refreshTable), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        gamesList = OXGameController.sharedInstance.getListOfGames()!
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        
        self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func refreshTable() {
        self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        
        OXGameController.sharedInstance.acceptGameWithId(gamesList[indexPath.item].gameId!)
        
        let bvc = BoardViewController()
        OXGameController.sharedInstance.setNetworkMode(true)
        self.navigationController?.pushViewController(bvc, animated: true)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = gamesList[indexPath.item].gameId! + ": " + gamesList[indexPath.item].hostUser!.email
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    @IBAction func startNewNetworkGameTapped(sender: UIButton) {
        let user = UserController.sharedInstance.logged_in_user!
        OXGameController.sharedInstance.createNewGame(user)
        
        let bvc = BoardViewController()
        OXGameController.sharedInstance.setNetworkMode(true)
        self.navigationController?.pushViewController(bvc, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
