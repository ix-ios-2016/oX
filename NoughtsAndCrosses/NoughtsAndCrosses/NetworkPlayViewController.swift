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
      
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameListComplete, message) in self.gameListComplete(gameListComplete, message:message)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable() {
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameListComplete, message) in self.gameListComplete(gameListComplete, message: message)})
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    func gameListComplete(gameListComplete:[OXGame]?,message:String?) {
        
        if let _ = gameListComplete
        {
            
            gameList = gameListComplete!
            tableView.reloadData()
            refreshControl.endRefreshing()

            
        }   else    {
            
            //registration failed
            let alert = UIAlertController(title:"Table Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        }
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
    
    func acceptGameComplete(game: OXGame?, message: String?)
    {
        if let _ = game
        {
            
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkMode = true
            self.navigationController?.pushViewController(bvc, animated: true)
            
            
        }   else    {
            
            //registration failed
            let alert = UIAlertController(title:"Table Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("hi")
        OXGameController.sharedInstance.acceptGame(gameList[indexPath.row].gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game, message: message)})
    }
    
    @IBAction func networkPlayTapped(sender: UIButton)
    {
        
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.logged_in_user!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.createNewGameComplete(game, message: message)})

    }
    
    func createNewGameComplete(game: OXGame?, message: String?) {
        
        if let _ = game
        {
            
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkMode = true
            self.navigationController?.pushViewController(bvc, animated: true)
            
            
        }   else    {
            
            //registration failed
            let alert = UIAlertController(title:"Table Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        }
        
    }
    
}

















