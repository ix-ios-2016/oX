//
//  networkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 6/5/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class networkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var gameList: [OXGame] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Game"
        self.navigationController?.navigationBarHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        gameList = OXGameController.sharedInstance.getListOfGames()!
        
        gameList.append(OXGame())
        gameList.append(OXGame())
        gameList.append(OXGame())
        
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row \(indexPath.row)")
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        self.navigationController?.pushViewController(bvc, animated: true)
        self.navigationController?.navigationBarHidden = true
        bvc.networkPlay = true
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gameList.count > 0 {
            return gameList.count
        } else {
            return 0
        }
        
        //        if let gameList = gameList {
//            return gameList.count
//        } else {
//            return 0
//        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = OXGameController.sharedInstance
        cell.textLabel!.text = game.getListOfGames()![indexPath.row].hostUser!.email
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
