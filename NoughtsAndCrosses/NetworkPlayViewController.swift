//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var gameTable: UITableView!
    @IBOutlet weak var gameButton: UIButton!
    var gamesList = OXGameController().getListOfGames()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Play"
        gameTable.dataSource = self
        gameTable.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    @IBAction func gameButtonTapped(sender: AnyObject) {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // let game = OXGameController().acceptGameWithId()
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.navigationController?.pushViewController(bvc, animated: true)
        print("did select row \(indexPath.row)")
        bvc.networkMode = true

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let index = indexPath.item
        let user = gamesList![index]
        cell.textLabel?.text = user.hostUser?.email
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    
}
