//
//  JSONParser.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class JSONParser : Parser {
    var json : NSDictionary!
    
    override func parse(data : Data?) throws {
        try super.parse(data: data);
        if data != nil {
            if let _ : NSDictionary =  try JSONSerialization.jsonObject(with : data!, options: .allowFragments) as? NSDictionary   {
                self.json = try JSONSerialization.jsonObject(with : data!, options: .allowFragments) as! NSDictionary
                try  parse(json : self.json);
                
            }
        }
    }
    
    func parse(json : NSDictionary!) throws {
        
    }
    func parseArray(json : NSArray!) throws {
        
    }
}



