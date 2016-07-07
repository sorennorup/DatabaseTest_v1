//
//  myViewController.swift
//  UUWiki2
//
//  Created by Søren on 16/03/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit
// this is the view of the first result table view

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var arrayNum:Int = 0
    var rightMarginConstraint:NSLayoutConstraint?
     var topMarginConstraint:NSLayoutConstraint?
    var arrayOfResults:[ResultModel] = [ResultModel]()
    @IBOutlet var thisTableView: UITableView!
    
    var passTest:String!
    var inputString:String!
     func viewDidAppear(){
        
        print("hi")
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      self.thisTableView.rowHeight = 80
        self.thisTableView.showsHorizontalScrollIndicator = true
        self.thisTableView.tableFooterView = UIView()
   
       // Make an instance of the SQLlite add
      let db = SQLiteDB.sharedInstance();
       print(passTest)
        
        self.inputString = passTest.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        //select in row named "Begreb"
        let query = "select * from Forkortelser2 WHERE Begreb like ?  "
        //select in row named "Fuldbetegnelse"
        let query2 = "select * from Forkortelser2 WHERE Fuldbetegnelse like ?"
        //select in row named "Beskrivelse"
        //let query3 = "select * from Forkortelser2 WHERE Beskrivelse like ?"
        
        
        
        // The results from the row named Begreb
        let begreb = db.query(query,parameters:[inputString + "%"] )
        let fuldbetegnelse = db.query(query2,parameters:[inputString + "%"] )
        
        if begreb.count == 0{
            print("nul");
                       
        }
        
        
        if begreb.count > 0{
       self.setUpResults(begreb)
        }
        else if fuldbetegnelse.count > 0{
       self.setUpResults(fuldbetegnelse)
        }
        if begreb.count == 1{
            print("yes der er kun et resultat. Gå direkte til 3. view")
            
            
           
            

            
        }
        else if fuldbetegnelse.count == 1{
            print("yes kun et resultat. Gå direkte til 3. view")
        }
        else{
         
        }
          // if the table contain results place the "forrige" button
        if !arrayOfResults.isEmpty {
                self.placeButton(20)
        }
        if arrayOfResults.isEmpty{
            self.addTextField()
           
            
        }

    }
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayOfResults.count
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:customCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! customCellTableViewCell
        print(indexPath.row);
        
        
        let re = arrayOfResults[indexPath.row];
                if arrayOfResults.count == 1{
            let viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("viewController") as! ViewController
            viewController.begrebString = re.begreb
            viewController.fullNameString = re.fuldbetegnelse
            viewController.beskrivelse = re.beskrivelse
            viewController.replacedWidth = re.nuKaldet
            viewController.alsoCalledString = re.ogsaaKaldet
            viewController.replaces = re.erstatter
            viewController.linkRead = re.linket
            viewController.seeMore = re.laesMere
            
            // the variable containing the inputstring to pass between views
            viewController.passTest = re.inputStr
                       
            self.presentViewController(viewController, animated:true, completion:nil)
            

        }
        
        
        cell.begrebLabel.text = re.begreb
        cell.fuldbetegnelseLabel.text = re.fuldbetegnelse
            return cell

       
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let res = arrayOfResults[indexPath.row]
        // Save arraynumber as an global variable
        arrayNum = indexPath.row
        print(res.begreb)
        print(res.ogsaaKaldet)
        print(res.nuKaldet)
        let viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("viewController") as! ViewController
        viewController.begrebString = res.begreb
        viewController.fullNameString = res.fuldbetegnelse
        viewController.beskrivelse = res.beskrivelse
        viewController.replacedWidth = res.nuKaldet
        viewController.alsoCalledString = res.ogsaaKaldet
        viewController.replaces = res.erstatter
        viewController.linkRead = res.linket
        viewController.seeMore = res.laesMere
       
        // the variable containing the inputstring to pass between views
        viewController.passTest = res.inputStr
        viewController.num = arrayNum
        
        
        self.presentViewController(viewController, animated:true, completion:nil)
        
            }
    
   
    // sets up all the results in the ResultModel
       
    func setUpResults(myObject:[SQLRow]) {
        
        var nameRest:String = " "
        var allName:String = " "
        var description:String = " "
        var replaced:String = " "
        var alsoCalled:String = " "
        var linkRead:String = " "
        var replaces:String = " "
        var readMore:String = ""
        for var index = 0; index < myObject.count;++index{
            
            print(myObject.count, terminator: "")
            let row = myObject[index]
            
            if let name = row["Begreb"]{
                nameRest = name.asString()
            }
            if let fullName = row["Fuldbetegnelse"]{
                 allName = fullName.asString()
               

            }
            if let desc = row["Beskrivelse"]{
                description = desc.asString()
            }
             print(row["Nukaldet"]?.asString())
            if let repla = row["Erstattetaf"]{
                replaced = repla.asString()
                
                 print("her skulle replaced læses")
                
            }
             print(replaced)
            if let also = row["Ogsåkaldet"]{
                
                alsoCalled = also.asString()
                print("her bliver var læst")
            }
            
            if let linkRes = row["Link"]{
                linkRead = linkRes.asString()
            }
            if let replace = row["Erstatter"]{
                replaces = replace.asString()
            }
            if let read = row["Læsmere"]{
                readMore = read.asString()
            }
            
            
            
                
                
                let res = ResultModel(begreb:nameRest, fuldbetegnelse:allName, beskrivelse: description, ogsaaKaldet:alsoCalled, nuKaldet:replaced,linket:linkRead,laesMere:readMore,erstatter:replaces,inputStr:inputString)
                
                self.arrayOfResults.append(res)
                
                
                
            
            
            
        }
        
    }
    
        
    func placeButton(topMargin:CGFloat){
        
        let button   = UIButton(type:UIButtonType.System) as UIButton
        
       button.translatesAutoresizingMaskIntoConstraints = false

             button.frame = CGRectMake(210,100,10,10)
            //button.backgroundColor = UIColor.whiteColor()
        
            button.setTitle("forrige >", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
           button.titleLabel!.font =  UIFont(name:"Trebuchet MS" , size: 15)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        if #available(iOS 8.0, *) {
           topMarginConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 27)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 8.0, *) {
            rightMarginConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.RightMargin, multiplier: 1, constant: 4)
        } else {
            // Fallback on earlier versions
        }
        //addConstraint
        
        // add constraint
        
        
            self.view.addSubview(button)
        self.view.addConstraint(self.rightMarginConstraint!)
          self.view.addConstraint(self.topMarginConstraint!)
        
        
        
        
        
       
        

        

        
        
        
        
        
        
    }
    
    func buttonAction(sender:UIButton!){
        print("action")
        let re = arrayOfResults[arrayNum];
        let viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("viewController") as! ViewController
        viewController.begrebString = re.begreb
        viewController.fullNameString = re.fuldbetegnelse
        viewController.beskrivelse = re.beskrivelse
        viewController.replacedWidth = re.nuKaldet
        viewController.alsoCalledString = re.ogsaaKaldet
        viewController.replaces = re.erstatter
        viewController.linkRead = re.linket
        viewController.seeMore = re.laesMere
        
        // the variable containing the inputstring to pass between views
        viewController.passTest = re.inputStr
        
        self.presentViewController(viewController, animated:true, completion:nil)
    }

    func addTextField(){
        let myField: UITextField = UITextField (frame:CGRectMake(50, 20, 150, 100));
        myField.text = " intet resultat på " + self.inputString
        myField.textColor = UIColor.whiteColor()
        
        //myField.backgroundColor = UIColor.blackColor()
        
        self.thisTableView.addSubview(myField)
        self.thisTableView.backgroundColor = UIColor.blackColor()
        

}
    func setAutoLayoutDim(){
        
    }
}

