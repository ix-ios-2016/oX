//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var gamesTableView: UITableView!
    
    // create list of all the OXGame instances
    var gamesList = OXGameController.sharedInstance.getListOfGames()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Network Play"
        // set the table's data source
        gamesTableView.dataSource = self
        // set the table's delegate???
        gamesTableView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // perform actions for row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        
        let networkGameView = BoardViewController(nibName: "BoardViewController", bundle: nil)
        
        networkGameView.networkMode = true
        
        self.navigationController?.pushViewController(networkGameView, animated: true)
        
        
        
    }
    
    // set number of secitons in the table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // set number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList!.count
    }
    
    // return the cell at the index path???
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // create a cell for the row at index
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = gamesList![indexPath.item].hostUser!.email
        return cell
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }

}
