//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gamesList: [OXGame] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        
//        if OXGameController.sharedInstance.getListOfGames()?.count != 0 {
//            for game in OXGameController.sharedInstance.getListOfGames()! {
//                gamesList.append(game)
//            }
//        }
        
        var refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshControl.addTarget(self, action:"refreshTable", forControlEvents:UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gamesListReceived(gameList, message:message)})
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gamesListReceived(gameList, message:message)})
        //need to instantiate gamesListRecieved
        
    }
    
    func gamesListReceived(games:[OXGame]?, message:String?){
        if let newGames = games {
            self.gamesList = newGames
        }
        self.tableView.reloadData()
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.navigationController?.pushViewController(bvc, animated: true)
        print("did select row \(indexPath.row)")
        bvc.networkGame = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(gamesList[indexPath.row].hostUser!.email)
        let hostEmail = gamesList[indexPath.row].hostUser!.email
        cell.textLabel?.text = hostEmail
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }

    

}
