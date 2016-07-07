//
//  ViewController.swift
//  DatabaseTest
//
//  Created by Søren on 23/02/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit
// This is the view containing the specified result, with full description field and link to add. information

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var begrebString:String?
    var fullNameString:String?
    var beskrivelse:String?
    var replacedWidth:String?
    var alsoCalledString:String?
    var linkRead:String?
    var replaces:String?
    var seeMore:String?
    var passTest:String?
    var strArray:[String] = []
    var restArray:[String] = []
    var num:Int = 0
    
    @IBOutlet weak var shortDefinition: UITextField!
   
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var labelNowCalled: UITextField!
    
    @IBOutlet weak var desciption: UITextView!

    @IBOutlet weak var replacing: UILabel!
  
    @IBOutlet weak var linkDisplay: UITextField!
    @IBOutlet weak var nowCalled: UILabel!
   
    @IBOutlet weak var alsoCalled: UILabel!
    var button:UIButton?
    
    
    @IBOutlet var myTableView: UITableView!

   
    let rowArray = [SQLRow]()
    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.myTableView.tableFooterView = UIView()
       print("num: ")
        print(num)
        self.myTableView.rowHeight = 44
        self.shortDefinition.text = " "+begrebString!
        self.fullName.text = " "+fullNameString!
        self.desciption.text = beskrivelse!
        self.strArray = [replacedWidth!,alsoCalledString!,replaces!,seeMore! ]
        for var index = 0; index < strArray.count;++index{
            if strArray[index].isEmpty == false{
                self.restArray.append(strArray[index])
            }
        }
        
         }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:CustomTableViewCell2 = tableView.dequeueReusableCellWithIdentifier("Cell2") as! CustomTableViewCell2
        print(indexPath.row);
        let res:String = restArray[indexPath.row];
        
        
        if restArray[indexPath.row].isEmpty == false {
            if res == replacedWidth {
        cell.label1.text = "Erstattet af:  "
                
            }
            else if res == alsoCalledString{
                cell.label1.text = "Også kaldet: "
            }
            else if res == replaces{
                cell.label1.text = "Erstatter: "
            }
            else if res == seeMore{
                cell.label1.text = "Læs mere på:"
            }
            
            cell.label2.text = res
          }
        return cell
        
        
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if restArray[indexPath.row] == seeMore!{
        if let url = NSURL(string:linkRead! ) {
            UIApplication.sharedApplication().openURL(url)
        }
        }
        else if restArray[indexPath.row] == replacedWidth{
            buttonAction()
        }
        
    }

    

    
    
   
    
    
    func buttonAction()
    {    var str:String?
        print("action is clicked")
        
        if (replacedWidth?.isEmpty == false){
        str = replacedWidth!;
        }
        else if (alsoCalledString?.isEmpty == false){
            str = alsoCalledString!;
        }
        
        let db = SQLiteDB.sharedInstance();
        
        
        
        //select in row named "Begreb"
        let query = "select * from Forkortelser2 WHERE Begreb like ?  "
        //select in row named "Fuldbetegnelse"
        //let query2 = "select * from Forkortelser2 WHERE Fuldbetegnelse like ?"
        //select in row named "Beskrivelse"
         //let query3 = "select * from Forkortelser2 WHERE Beskrivelse like ?"
        
        
        
        // The results from the row named Begreb
        let begreb = db.query(query,parameters:[str! + "%"] )
        //let fuldbetegnelse = db.query(query2,parameters:[str! + "%"] )
        if begreb.count > 0{
            let row = begreb[0]
            
            
            
            
            if let name = row["Begreb"]{
                self.shortDefinition.text = " "+name.asString()
            }
            if let fullNameStr = row["Fuldbetegnelse"]{
                self.fullName.text = " " + fullNameStr.asString()
                
                
                
            }
            if let desc = row["Beskrivelse"]{
                self.desciption.text = desc.asString()
            }
            
            
                
            
            if let also = row["Ogsaakaldet"]{
                
                self.alsoCalled.text = also.asString()
                print("her bliver var læst")
            }
        }

    }
   
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "argBack") {
            let svc = segue!.destinationViewController as! MyViewController;
            
             svc.passTest = passTest!
             svc.arrayNum = num
            
        
        }
    }

    
    
        
       var hey:String!
    
    
    }



