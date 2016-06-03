//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Joe Salter on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gamesList: [OXGame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        self.title = "Network Play"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        gamesList = OXGameController.sharedInstance.getListOfGames()!
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        
        let bvc = BoardViewController()
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = gamesList[indexPath.item].hostUser!.email
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
