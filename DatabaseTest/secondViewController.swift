//
//  secondViewController.swift
//  DatabaseTest
//
//  Created by Søren on 26/02/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit
// This Viewcontroller controls the view of the search field 
// Get the data.db file from the server

class secondViewController:UIViewController, UITableViewDelegate,UISearchBarDelegate, UISearchControllerDelegate,NSURLSessionTaskDelegate  {
    
    var downloadTask: NSURLSessionDownloadTask!
    var backgroundSession: NSURLSession!
    
    var button   = UIButton(type:UIButtonType.System)as UIButton
    
    let alertController = UIAlertController(title:"Velkommen til UU Wiki", message:"For at hente den senest opdaterede ordbog skal du klikke på ok og starte appen igen.(Dette er kun nødvendigt første gang du bruger appen)" ,preferredStyle: UIAlertControllerStyle.Alert)
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
   
    // String usede to pass to the next viewcontroller
    var passTest:String!
    
    // First time the app is launched the data.db file is not fetched from the server. 
    // In the viewDidAppear method a code will check if it is the first time
    // if it is it will show the user a popup alert telling him that he must restart the app
    // to got the updated data
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        if LaunchCheck.launchedForTheFirstTime() == true{
            alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                UIAlertAction in
                //exit(0)
                
                })
            self.presentViewController(alertController, animated: true, completion: nil)
                 }
        else{

            print("not launched for the first time")
            
        }
        
    }
    // This method checks if the device is connected to the internet
    // if it is it wil execute the downloadtask
    func executeDownloadTask(){
        if Reachability.isConnectedToNetwork() == true{
        print("just Checking")
        let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
        backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self,delegateQueue: NSOperationQueue.mainQueue())
        
        print("the download should be started")
        let the_path:String = UpdateDbFile.findPathInDocDir("data.db");// get the path for the data.db file
        UpdateDbFile.deleteFilewithPath(the_path) // delete the existing file
        startDownload()     // download the updated dbfile

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //call the executeDownloadTask method
        executeDownloadTask()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    // assigning and passing the input value into the other viewcontroller
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueSendingData") {
            let svc = segue!.destinationViewController as! MyViewController;
            
            if(mySearchBar.text == ""){
                svc.passTest = "dit søgeord ";
            }
            else{
            svc.passTest = mySearchBar.text
            }
            
        }
        else if(segue.identifier == "newSegue"){
            let svc2 = segue!.destinationViewController as! MyViewController;
           
            svc2.passTest = " "
            
        }
        
        
    }
    
     let db = SQLiteDB.sharedInstance();
   
    
 
    @IBAction func searchRes(sender: AnyObject) {
    
        }
    
    
    
    @IBAction func update(sender: AnyObject) {
       executeDownloadTask()
        let db = SQLiteDB.sharedInstance();
        print(db.recentFileName)
    
    }
    
    
    
    func startDownload() {
        
        let url = NSURL(string: "http://uudanmark.dk/data.db")!
        self.downloadTask = backgroundSession.downloadTaskWithURL(url)
        downloadTask.resume()
        
    }
    
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didFinishDownloadingToURL location: NSURL){
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
            let fileManager = NSFileManager()
            let destinationURLForFile = NSURL(fileURLWithPath: path.stringByAppendingString("/data.db"))
            
            if fileManager.fileExistsAtPath(destinationURLForFile.path!){
                
            }
            else{
                do {
                    try fileManager.moveItemAtURL(location, toURL: destinationURLForFile)
                    // show file
                    
                }  catch{
                    print("An error occurred while moving file to destination url")
                }
            }
    }

}




