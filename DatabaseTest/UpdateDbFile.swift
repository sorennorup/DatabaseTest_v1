
    import UIKit
    
class UpdateDbFile {
    
    class func theDownloadTask(){
           }
    
    
    class func deleteFilewithPath(path:String){
        let fileManager = NSFileManager.defaultManager()
        
        
        do {
            try fileManager.removeItemAtPath(path)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        
    }
    // new change

     class func findPathInDocDir(var filename:String)->String{
         filename = "/"+filename
        // get the path for the data.db file
        let myPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)[0] as String
        let finalPath = myPath + filename
        print(myPath + "/data.db")
        return finalPath

    }
    
    }






