//
//  MarvelStory.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class MarvelStory : MarvelItem  {
    
    var type: String
    
    override init(name: String, resourceURI: String) {
        self.type = ""
        super.init(name: name, resourceURI: resourceURI)
    }
    
    required public init? (coder aDecoder: NSCoder){
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        super.init(coder: aDecoder)
    }
    
    public override func encode(with aCoder: NSCoder){
        aCoder.encode(type, forKey: "type")
        super.encode(with: aCoder)
    }
    
}

