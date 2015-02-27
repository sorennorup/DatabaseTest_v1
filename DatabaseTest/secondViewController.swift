//
//  secondViewController.swift
//  DatabaseTest
//
//  Created by Søren on 26/02/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    
    
    @IBOutlet weak var textInputField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // assigning and passing the input value into the other viewcontroller
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "segueSendingData") {
            var svc = segue!.destinationViewController as ViewController;
            
            svc.passTest = textInputField.text
            
        }
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
