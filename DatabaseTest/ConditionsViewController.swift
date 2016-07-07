//
//  ConditionsViewController.swift
//  UUWiki
//
//  Created by Søren on 12/06/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit


class ConditionsViewController: NavigationControllerLinks
 {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backSearch(sender: AnyObject) {
        linkToViewController("tabBarController")
    }
      
    
   
   

}
