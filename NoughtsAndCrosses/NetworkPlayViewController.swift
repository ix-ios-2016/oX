//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Justin on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var gamesList = [OXGame]() // Might need to be optional
    var refreshControl : UIRefreshControl!
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBarHidden = false
        
        self.title = "Network Play"
        tableView.dataSource = self
        tableView.delegate = self
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction:{(gameList,message) in self.getListComplete(gameList,message:message)})

        
        
//        UserController.sharedInstance.loginUser(emailGiven!, password: passwordGiven!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.logInComplete(user,message:message)})
        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: "refreshTable", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        
    }
    
    func getListComplete (gameListIn:[OXGame]?, message: String?) {
        
        
        print("Set game list here")
        if let gameListSuccessful = gameListIn  {
            //if the game list call succeeded
            gamesList = gameListSuccessful
            tableView.reloadData()
            
        }    else{
            
            //tbe call did not succeed
        }
        
        
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

//        self.gamesList = OXGameController.sharedInstance.getListOfGames()!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func gamesListReceived(games: [OXGame]?, message: String?){
        
        print("games received \(games)")
        
        if let newGames = games {
            self.gamesList = newGames
        }
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gamesListReceived(gameList, message: message)})
    }
    
    
    //Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!gamesList.isEmpty){
            return gamesList.count
        }
        else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(self.gamesList[indexPath.row].hostUser!.email), ID: \(self.gamesList[indexPath.row].gameId!)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    //Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var gameRowSelected = self.gamesList[indexPath.row]
        
        OXGameController.sharedInstance.acceptGame(gameRowSelected.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game, message: message)})
        print("did select row \(indexPath.row)")
//        var game = OXGameController.sharedInstance.acceptGameWithId(self.gamesList[indexPath.row].gameId!) //Need to do something with this
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
        
    }
    
    func acceptGameComplete(game: OXGame?, message: String?){
        print("accept game call complete")
        
        if let gameAcceptedSuccess = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkMode = true
            networkBoardView.currentGame = gameAcceptedSuccess
            self.navigationController?.pushViewController(networkBoardView, animated: true)
            
        }
    }
    
    func refreshTable(){
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction:{(user,message) in self.getListComplete(user, message:message)})
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    @IBAction func newGamePressed(sender: AnyObject) {
//        var newUser = User(email: "h@e.com", password: "1", token: "", client: "")
////        OXGameController.sharedInstance.createNewGame(newUser)
//        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
//        bvc.networkMode = true
//        self.navigationController?.pushViewController(bvc, animated: true)
        
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!,presentingViewController: self,  viewControllerCompletionFunction: {(game, message) in self.newStartGameCompleted(game,message: message)})
    }
    
    func newStartGameCompleted(game: OXGame?, message: String?){
        
        if let newGame = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkMode = true
            networkBoardView.currentGame = newGame
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        }
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
