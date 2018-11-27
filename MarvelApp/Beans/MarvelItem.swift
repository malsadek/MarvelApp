//
//  MarvelItem.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek  on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class MarvelItem : NSObject, NSCoding  {
    var name: String
    var resourceURI: String
    
    init(name: String, resourceURI: String) {
        self.name = name;
        self.resourceURI = resourceURI;
    }
    required public init? (coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.resourceURI = aDecoder.decodeObject(forKey: "resourceURI") as! String
    }
    public func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(resourceURI, forKey: "resourceURI")
    }
}


