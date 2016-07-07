//
//  NavigationControllerLinks.swift
//  UUWiki
//
//  Created by Søren on 12/06/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit

class NavigationControllerLinks: UIViewController {
    
    
     /*func linkToViewController(){
        let viewController:UIViewController   = (self.storyboard?.instantiateInitialViewController())!}*/
    
    func linkToViewController(identifier:String){
            
            let viewController:UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
        

        
        self.presentViewController(viewController, animated:true, completion:nil)
    }
    
    
 
   
}
