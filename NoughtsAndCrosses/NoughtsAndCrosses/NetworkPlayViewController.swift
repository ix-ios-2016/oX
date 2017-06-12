//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gamesList = [OXGame]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBarHidden = false
        self.title = "Network Play"
        /*
        let game1 = OXGame()
        let game2 = OXGame()
        
        gamesList += [game1, game2]
        */

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gameListReceived(gameList, message: message)})
    }
    
    func gameListReceived(games: [OXGame]?, message:String?) {
        print("Games received \(games)")
        if let newGames = games {
            self.gamesList = newGames
        }
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
        
        OXGameController.sharedInstance.gameList(viewControllerCompletionFunction: {(gamesList, message)
            in self.gameListReceived(gamesList, message:message)})
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let gameRowSelected = self.gamesList[indexPath.row]
        
        OXGameController.sharedInstance.acceptGame(gameRowSelected.gameId!, presentingViewController: self, viewControllerCompletionFunction:{(game, message) in self.acceptGameComplete(game, message: message)})
        
        
        print("did select row \(indexPath.row)")
    }
    
    func acceptGameComplete(game:OXGame?, message:String?) {
        print("accept game call complete")
        if let gameAcceptedSuccess = game {
            let networkBoardView = BoardViewController(nibName: "BoardViewController", bundle: nil)
            networkBoardView.networkGame = true
            networkBoardView.currentGame = gameAcceptedSuccess
            self.navigationController?.pushViewController(networkBoardView, animated: true)
        
        }
    }

    @IBAction func startNetworkGameButtonTapped(sender: AnyObject) {
        print("startNetworkGameBUttonTapped")
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.newStartGameCompleted(game, message: message)})
    }
    
    func newStartGameCompleted(game:OXGame?, message:String?) {
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
        if (gamesList.count > 0) {
            return gamesList.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "id: \(gamesList[indexPath.row].gameId!) user:\(gamesList[indexPath.row].hostUser!.email)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
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
