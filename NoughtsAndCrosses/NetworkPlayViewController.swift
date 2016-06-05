//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Justin on 6/3/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gamesList = [OXGame]() // Might need to be optional
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBarHidden = false
        
        self.title = "Network Play"
        tableView.dataSource = self
        tableView.delegate = self
        
        gamesList = OXGameController.sharedInstance.getListOfGames()!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

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
        var game = OXGameController.sharedInstance
        cell.textLabel?.text = game.getListOfGames()![indexPath.row].hostUser!.email // NEEDS CHANGE FROM ANOTHER TO ANOTHER VARIABLE
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Online Games"
    }
    
    //Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row \(indexPath.row)")
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        bvc.networkMode = true
        self.navigationController?.pushViewController(bvc, animated: true)
        
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
