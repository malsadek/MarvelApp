//
//  Parser.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit

class Parser: NSObject {
    var response : HTTPURLResponse!;
    var done : Bool! = Bool()
    func parse(data : Data?, response : URLResponse?) -> () {
        if let response = response as? HTTPURLResponse {
            self.response = response;
            do {
                self.done = (response.statusCode == 200);
                try parse(data: data);
                return;
            }
            catch {
            }
        }
        self.done = false;
    }
    
    func isDone() -> Bool {
        return self.done;
    }
    
    func getResponse() -> HTTPURLResponse {
        return self.response;
    }
    
    func parse(data : Data?) throws {
    }
}



