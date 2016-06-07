//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//


import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gameList: [OXGame] = []
    
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
      
        
        gameList = OXGameController.sharedInstance.getListOfGames()!
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        
        self.gameList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print (gameList.count)
        return gameList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Avaible Network Games"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = "id: \(gameList[indexPath.row].gameId!)  user: \(gameList[indexPath.row].hostUser!.email)"
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("hi")
        OXGameController.sharedInstance.setCurrentGame(OXGameController.sharedInstance.acceptGameWithId(gameList[indexPath.row].gameId!)!)
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
    @IBAction func networkPlayTapped(sender: UIButton)
    {
        
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.logged_in_user!)
        
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
}

















