//
//  MarvelImage.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class MarvelImage : NSObject, NSCoding  {
    
    let fileExtension: String!
    let nonSecurePath: String!
    
    init(path: String, fileExtension: String) {
        self.nonSecurePath = path;
        self.fileExtension = fileExtension;
        
    }
    required public init? (coder aDecoder: NSCoder){
        self.nonSecurePath = aDecoder.decodeObject(forKey: "path") as? String
        self.fileExtension = aDecoder.decodeObject(forKey: "fileExtension") as? String
    }
    public func encode(with aCoder: NSCoder){
        aCoder.encode(nonSecurePath, forKey: "path")
        aCoder.encode(fileExtension, forKey: "fileExtension")
    }
    
    public var path: String!{
        return self.securePath(path: nonSecurePath)
    }
    public var urlString: String?{
        return self.securePath(path: self.nonSecurePath) + "." + self.fileExtension!
    }
    public var url: URL? {
        return URL(string: urlString!)
    }
    func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
}


