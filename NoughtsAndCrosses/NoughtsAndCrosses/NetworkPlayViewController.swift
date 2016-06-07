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
    
    var gamesList: [OXGame] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
      
        
        gamesList = OXGameController.sharedInstance.getListOfGames()!
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print (gamesList.count)
        return gamesList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Avaible Network Games"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = gamesList[indexPath.row].hostUser!.email
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("hi")
        OXGameController.sharedInstance.setCurrentGame(OXGameController.sharedInstance.acceptGameWithId(gamesList[indexPath.row].gameId!)!)
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
    @IBAction func networkPlayTapped(sender: UIButton)
    {
        
    }
    
}

















