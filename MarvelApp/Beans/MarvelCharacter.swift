//
//  MarvelCharacter.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class MarvelCharacter : NSObject, NSCoding  {
    let id: Int;
    let name: String;
    let descr: String;
    let comics: [MarvelItem];
    let events: [MarvelItem];
    let stories: [MarvelItem];
    let series: [MarvelItem];
    let thumbnail: MarvelImage;
    
    init(id: Int, name: String, comics: [MarvelItem], events: [MarvelItem], stories: [MarvelItem], series: [MarvelItem], descr: String, thumbnail: MarvelImage) {
        self.id = id;
        self.name = name;
        self.comics = comics;
        self.events = events;
        self.stories = stories;
        self.series = series;
        self.descr = descr;
        self.thumbnail = thumbnail;
    }
    
    required public init? (coder aDecoder: NSCoder){
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.comics = aDecoder.decodeObject(forKey: "comics") as! [MarvelItem]
        self.stories = aDecoder.decodeObject(forKey: "stories") as! [MarvelItem]
        self.events = aDecoder.decodeObject(forKey: "events") as! [MarvelItem]
        self.series = aDecoder.decodeObject(forKey: "series") as! [MarvelItem]
        self.descr = aDecoder.decodeObject(forKey: "descr") as! String
        self.thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as! MarvelImage
        
        
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(comics, forKey: "comics")
        aCoder.encode(events, forKey: "events")
        aCoder.encode(stories, forKey: "stories")
        aCoder.encode(series, forKey: "series")
        aCoder.encode(descr, forKey: "descr")
        aCoder.encode(thumbnail, forKey: "thumbnail")
        
    }
    
}

