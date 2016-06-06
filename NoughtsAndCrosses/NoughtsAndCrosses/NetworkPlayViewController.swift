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
    @IBOutlet weak var TableView: UITableView!
    var gameList = [OXGame]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Play"
        TableView.dataSource = self
        TableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        TableView.addSubview(refreshControl)


    }
    func refreshTable(){
        self.gameList = OXGameController.sharedInstance.getListOfGames()!
        self.TableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        gameList = OXGameController.sharedInstance.getListOfGames()!
        
        self.gameList = OXGameController.sharedInstance.getListOfGames()!
        self.TableView.reloadData()
        refreshControl.endRefreshing()

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
        //2c: How do you show the specific game you created to the user?
        
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil )
        OXGameController.sharedInstance.acceptGameWithId(String(gameList[indexPath.row].gameID))
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
    
    @IBAction func networkGameButtonTapped(sender: UIButton) {
        OXGameController.sharedInstance.createNewGame( (UserController.sharedInstance.logged_in_user)! )
//        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil )
//        bvc.networkMode = true
//        self.navigationController?.pushViewController(bvc, animated: true)
    }
    

}
