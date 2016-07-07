//
//  ResultModel.swift
//  UUWiki2
//
//  Created by Søren on 17/03/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import Foundation
class ResultModel{
    var begreb:String = "default"
    var fuldbetegnelse: String = "default"
    var beskrivelse: String = "default"
    var ogsaaKaldet: String = "default"
    var nuKaldet:String = "default"
    var linket:String = "default"
    var laesMere:String = "default"
    var erstatter:String = "default"
    var inputStr:String = "default"
    
    init(begreb:String,fuldbetegnelse:String,beskrivelse:String, ogsaaKaldet:String, nuKaldet:String,linket:String,laesMere:String,erstatter:String ,inputStr:String){
        
        self.begreb = begreb
        self.fuldbetegnelse = fuldbetegnelse
        self.beskrivelse = beskrivelse
        self.ogsaaKaldet = ogsaaKaldet
        self.nuKaldet =  nuKaldet
        self.linket = linket
        self.laesMere = laesMere
        self.erstatter = erstatter
            self.inputStr = inputStr
        
    }
    
    
    
    
    
    
    
    
}