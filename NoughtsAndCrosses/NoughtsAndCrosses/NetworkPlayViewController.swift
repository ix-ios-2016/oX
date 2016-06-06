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
        let game1 = OXGame(); gamesList.append(game1)
        let game2 = OXGame(); gamesList.append(game2)
        let game3 = OXGame(); gamesList.append(game3)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

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
        cell.textLabel?.text = "test cell label"
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }

    

}
