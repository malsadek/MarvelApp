//
//  CharacterParser.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import Foundation

class CharacterParser : BaseParser {
    
    private var count: Int!
    private var limit: Int!
    private var total: Int!
    private var offset: Int!
    private var results: [MarvelCharacter]!
    
    
    override func parseSuccess(data: NSDictionary!) throws {
        try super.parseSuccess(data: data);
        
        self.count = data["count"] as? Int
        self.limit = data["limit"] as? Int
        self.total = data["total"] as? Int
        self.offset = data["offset"] as? Int
        
        let resultsArray = data["results"] as! NSArray
        self.results = [MarvelCharacter]()
        for result in resultsArray{
            let resultDictionary = result as! NSDictionary
            let id  = resultDictionary["id"] as! Int
            let name = resultDictionary["name"] as! String
            
            let comicsDictionary = resultDictionary["comics"] as! NSDictionary
            let (comicsAvailable, comicsReturned, comicsCollectionURI,comics )  =  getItems(itemDictionary: comicsDictionary)
            let descr = resultDictionary["description"] as! String
            
            let eventsDictionary = resultDictionary["events"] as! NSDictionary
            let (eventsAvailable, eventsReturned, eventsCollectionURI,events)  =  getItems(itemDictionary: eventsDictionary)
            
            let seriesDictionary = resultDictionary["series"] as! NSDictionary
            let (seriesAvailable, seriesReturned, seriesCollectionURI,series)  =  getItems(itemDictionary: seriesDictionary)
            
            let storiesDictionary = resultDictionary["stories"] as! NSDictionary
            let (storiesAvailable, storiesReturned, storiesCollectionURI,stories)  =  getItems(itemDictionary: storiesDictionary)
            
            let thumbnailDictionary = resultDictionary["thumbnail"] as! NSDictionary
            let thumbnailExt = thumbnailDictionary["extension"] as! String
            let thumbnailPath = thumbnailDictionary["path"] as! String
            let thumbnail = MarvelImage(path: thumbnailPath, fileExtension: thumbnailExt)
            
            let character = MarvelCharacter(id: id, name: name, comics: comics, events: events, stories: stories, series: series, descr: descr, thumbnail: thumbnail)
            self.results.append(character)
            
            //       print("data \(data)")
        }
        
    }
    
    func getItems(itemDictionary: NSDictionary) -> (Int, Int, String, [MarvelItem]){
        let available = itemDictionary["available"] as! Int
        let returned = itemDictionary["returned"] as! Int
        let collectionURI = itemDictionary["collectionURI"] as! String
        let marvelItems = itemDictionary["items"] as! NSArray
        var items = [MarvelItem]()
        for marvelItem in marvelItems {
            let marvelItemDictionary = marvelItem as! NSDictionary
            let marvelItemName = marvelItemDictionary["name"] as! String
            let marvelItemURI = marvelItemDictionary["resourceURI"] as! String
            if let marvelItemType = marvelItemDictionary["type"] as? String{
                let marvelStory = MarvelStory(name: marvelItemName, resourceURI: marvelItemName)
                marvelStory.type = marvelItemType
                items.append(marvelStory)
            }else{
                items.append(MarvelItem(name: marvelItemName, resourceURI: marvelItemURI))
            }
            
            
        }
        return (available, returned, collectionURI,items)
    }
    
    func getResults() -> [MarvelCharacter]{
        return self.results
    }
    func getCount() -> Int{
        return self.count
    }
    func getLimit() -> Int{
        return self.limit
    }
    func getTotal() -> Int{
        return self.total
    }
    func getOffset() -> Int{
        return self.offset
    }
}

