//
//  MarvelRequests.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit
import CryptoSwift

class MarvelRequests : NSObject {
    static var sharedInstance =  MarvelRequests()
    let api: String = "https://gateway.marvel.com/"
//    let publicKey: String = "INSERT YOUR MARVEL PUBLIC KEY"
//    let privateKey: String = "INSERT YOUR MARVEL PRIVATE KEY"
    let publicKey: String = "d71553cd5c809dbc25feac28d1d7c363"
    let privateKey: String = "5260f0ccd0f1e1572fba13c06a16110bea6836a7"
    let ts = NSDate().timeIntervalSince1970.description
    
    override init(){
    }
    
    func characters(offset: Int) -> Request {
        
        return Request()
            .setUrl(_url: "https://gateway.marvel.com:443/v1/public/characters?apikey=\(publicKey)&ts=\(ts)&hash=\((ts + privateKey + publicKey).md5())")
            .addParam(name: "offset", value: "\(offset)")
            .setMethod(_method : Request.METHOD_GET)
            .setParser(parser: CharacterParser())
            .prepare();
    }
    
    
    
}

