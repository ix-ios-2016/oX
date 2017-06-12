//
//  NetworkPlayViewController.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/7/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NetworkPlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  //  *** 
//func gameListReceived (games:[OXGame}?,message:String?) {
    //print ("games received\(games)") 
      //  if let newGames = games {
      //  }
       //  self.tableView.reloadData()
      //  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated:Bool) {
        self.title = "Network Play"
        self.navigationController?.navigationBarHidden = false
    }
        
        //**** OXGameController.sharedInstance.gameList(self.viewCOntrollerCompletionFunction: ((gameList,message)
        // in self.gameListReceived(gameList, message:message)})

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
