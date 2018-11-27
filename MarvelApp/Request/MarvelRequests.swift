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
    let publicKey: String = "INSERT YOUR MARVEL PUBLIC KEY"
    let privateKey: String = "INSERT YOUR MARVEL PRIVATE KEY"
    let ts = NSDate().timeIntervalSince1970.description
    
    override init(){
    }
    
    func characters(offset: Int) -> Request {
        
        return Request()
            .setUrl(_url: "https://gateway.marvel.com:443/v1/public/characters?apikey=\(publicKey)&ts=\(ts)&hash=\((ts + privateKey + publicKey).md5())")
            .addParam(name: "offset", value: "\(offset)")
            .setMethod(_method : Request.METHOD_GET)
            .setParser(parser: BaseParser())
            .prepare();
    }
    
    
    
}

