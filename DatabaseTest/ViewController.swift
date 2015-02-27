//
//  ViewController.swift
//  DatabaseTest
//
//  Created by Søren on 23/02/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var passTest:String!
    @IBOutlet weak var shortDefinition: UITextField!
    @IBOutlet weak var textRes: UITextField!
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var labelNowCalled: UITextField!
    @IBOutlet weak var nowCalled: UITextField!
    @IBOutlet weak var desciption: UITextView!
    

    @IBOutlet weak var alsoCalled: UITextField!
    let db = SQLiteDB.sharedInstance();

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var inputString:String = passTest.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let query = "select * from Forkortelser2 WHERE Begreb like ?  "
        
        let query2 = "select * from Forkortelser2 WHERE Fuldbetegnelse like ?"
        let query3 = "select * from Forkortelser2 WHERE Beskrivelse like ?"
        let data2 = db.query(query2,parameters:[inputString + "%"])
        let data3 = db.query(query3,parameters:["%" + inputString + "%"])
        let data = db.query(query,parameters:[inputString + "%"] )
        //  if data contains no result try the other query
        if data.count == 0{
            let data2 = db.query(query2,parameters:[inputString + "%"])
          
            /* var alert = UIAlertController(title: "Vi fandt desværre ikke noget resultat", message: "Desværre ingen resultater på " + inputString, preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            self.presentViewController(alert, animated: true, completion:nil)*/
            
            self.textRes.text = "Desværre ingen resultater på " + inputString
            
            // if data2 contains a sqlrow
            if data2.count != 0{
                // get all the values and display in the textfields
                self.getValues(data2)
                
            }
            else if(data3.count != 0){
                self.getValues(data3)
            }
            
            
        }
            
        else{
            self.getValues(data)
        }

        

    }
   
   
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func getValues(myObject:[SQLRow]){
        let row = myObject[0]
        if let name = row["Begreb"]{
            self.shortDefinition.text = name.asString()
            
        }
        
        if let name = row["Fuldbetegnelse"]{
            
            self.textRes.text = name.asString()
        }
        if let called = row["Ogsåkaldet"]{
            let result:String = called.asString();
            colorBackground(result, myTextField: self.alsoCalled)
            //self.alsoCalled.text = called.asString()
        }
        if let beskrivelse = row["Beskrivelse"]{
           
            self.desciption.text = beskrivelse.asString()
            
        }
        if let name = row["Nukaldet"]{
            // if name is empty
            if name.asString().isEmpty{
                // remove present value
                self.nowCalled.text = " "
                // set the backgroundcolor to red
                self.nowCalled.backgroundColor = UIColor.redColor();
            }
            else{
                self.nowCalled.text = name.asString()
                self.nowCalled.backgroundColor = UIColor.whiteColor()
            }
        }

        
    }
    
    func anotherTest(){
        
    }
    
    
    func colorBackground(myString:String,myTextField:UITextField){
        if myString.isEmpty{
            myTextField.text = " "
            myTextField.backgroundColor = UIColor.redColor()
        }
            else{
                myTextField.text = myString
            myTextField.backgroundColor = UIColor.whiteColor();
            }
        }
    func test (){}
    var hey:String!
    
    }



