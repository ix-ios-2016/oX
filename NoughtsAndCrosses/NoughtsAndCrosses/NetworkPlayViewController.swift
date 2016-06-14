//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Serene Mirza on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gamesList: [OXGame]? = []
    
    //example games
    //var game1: OXGame
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for game in OXGameController.sharedInstance.getListOfGames()! {
//            gamesList.append(game)
//        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.title = "Network Play"
        tableView.dataSource = self
        tableView.delegate = self
        
        OXGameController.sharedInstance.gameList(self, viewControllerCompletionFunction: {(gameList, message) in self.gameListRecieved(gameList, message:message)})
    }
    
    
    @IBAction func createNewGame(sender: AnyObject) {
        OXGameController.sharedInstance.createNewGame(UserController.sharedInstance.getLoggedInUser()!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.newStartGame(game, message:message)})
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        print("did select row \(indexPath.row)")
        
        OXGameController.sharedInstance.acceptGame(self.gamesList![indexPath.row].gameId!,presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.acceptGameComplete(game, message: message)})
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hostEmail = gamesList![indexPath.row].hostUser!.email
        cell.textLabel?.text = hostEmail
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    func gameListRecieved(games: [OXGame]?, message: String?) {
        print("Games recieved \(games)")
        
        if let newGames = games {
            self.gamesList = newGames
        }
        self.tableView.reloadData()
    }
    
    func acceptGameComplete(game: OXGame?, message: String?) {
        if let acceptGameSuccess = game {
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkGame = true
            bvc.currentGame = acceptGameSuccess
            self.navigationController?.pushViewController(bvc, animated: true)
        }
    }
    
    func newStartGame(game: OXGame?, message: String?) {
        if let newGame = game {
            let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
            bvc.networkGame = true
            bvc.currentGame = newGame
            self.navigationController?.pushViewController(bvc, animated: true)
        }
    }
}
