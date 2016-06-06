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
    var gameList: [OXGame]!
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instantiate the table
        self.title = "Choose a Game"
        self.networkTable.dataSource = self
        self.networkTable.delegate = self
        self.gameList = OXGameController.sharedInstance.getListOfGames()
        
        // set up refresher controller
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(NetworkPlayViewController.refreshTable),
                                 forControlEvents: UIControlEvents.ValueChanged)
        networkTable.addSubview(refreshControl)
    }
    
    func refreshTable() {
        self.gameList = OXGameController.sharedInstance.getListOfGames()
        self.networkTable.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide navigation bar
        self.navigationController?.navigationBarHidden = false
        
        // refresh table
        self.gameList = OXGameController.sharedInstance.getListOfGames()
        self.networkTable.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        OXGameController.sharedInstance.acceptGameWithId(self.gameList[indexPath.row].gameId!)
        let newBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
        newBoardView.networkGame = true
        self.navigationController?.pushViewController(newBoardView, animated: true)
        
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
            "ID: \(self.gameList![indexPath.row].gameId!), Email: \(self.gameList![indexPath.row].hostUser?.email)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
        let user = User(email: "host", password: "host")
        OXGameController.sharedInstance.createNewGame(user)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
