//
//  BaseParser.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class BaseParser : JSONParser {
    var status : Bool!;
    var code :Int!;
    
    override init() {
        self.code = 0
        self.status = false
    }
    
    func isSuccessful() -> Bool {
        return self.status;
    }
    func parseSuccess(data : NSDictionary!) throws {
        
    }
    func parseArraySuccess(data : NSArray!) throws {
        
    }
    func parseStringSuccess(data : String!) throws {
        
    }
    override func parse(json: NSDictionary!) throws {
        do{
            try super.parse(json : json);
            
            let responseStatus = json["status"] as! String
            self.status =  responseStatus.uppercased().elementsEqual("OK")
            self.code = json["code"] as! Int
            
            if(self.isSuccessful()) {
                if let dict = json["data"] as? NSDictionary {
                    try parseSuccess(data: dict);
                }
                if let arr = json["data"] as? NSArray {
                    try parseArraySuccess(data: arr);
                }
                if let str = json["data"] as? String {
                    try parseStringSuccess(data: str);
                }
            }
        } catch {
            self.status = false
        }
    }
}
