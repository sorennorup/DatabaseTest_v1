//
//  LaunchCheck.swift
//  UUWiki
//
//  Created by Søren on 06/07/16.
//  Copyright © 2016 Søren. All rights reserved.
//

import Foundation
class LaunchCheck {
    
    class func launchedForTheFirstTime()->Bool{
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
        if launchedBefore  {
           return false
            
        }
        else {
            print("First launch, setting NSUserDefault.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
            return true
        }
    
    
}
}