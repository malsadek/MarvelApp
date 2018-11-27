//
//  Request.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit

class Request : NSObject {
    static var METHOD_GET : String! = "GET";
    static var METHOD_POST : String! = "POST";
    
    var parameters : [String : Any]! = [String : Any]()
    var headers : [String : String]! = [String : String]()
    var body: String!
    var url : String!
    var method : String!
    var parser : Parser!;
    
    override init() {
    }
    
    func prepare() -> Request {
        _ = self.addHeader(name :"Content-Type", value: "application/json")
        _ = self.addHeader(name :"Accept", value: "application/json")
        
        return self;
    }
    
    func addHeader(name: String, value: String) -> Request {
        headers.updateValue(value ,forKey: name)
        return self
    }
    
    func addBody(postString: String) -> Request{
        body = postString
        return self
        
    }
    func addParam(name: String, value: Any) -> Request {
        parameters.updateValue(value, forKey: name)
        return self
    }
    
    func setUrl( _url : String) -> Request {
        url =  _url;
        return self
    }
    
    func setMethod(_method : String) -> Request {
        self.method = _method;
        return self
    }
    
    func setParser(parser : Parser) -> Request {
        self.parser = parser;
        return self
    }
    
    func dataTask(completion: @escaping (_ : Parser, _ error : Error?) -> Void) {
        let config = URLSessionConfiguration.default
        var session = URLSession(configuration: config)
        session = URLSession.shared
        
        let _request = NSMutableURLRequest()
        _request.httpMethod = self.method
        if(self.method == "POST") {
            if body != nil {
                _request.httpBody = body.data(using: String.Encoding.utf8)
            }else{
                _request.httpBody = try? JSONSerialization.data(withJSONObject : self.parameters , options: [])
            }
            
        }
        else {
            var _parameters : String = "";
            if(self.url.contains("?")) {
                _parameters += "&";
            }
            for (key) in self.parameters.keys {
                _parameters += key + "=" + (self.parameters[key]! as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&";
            }
            self.url = self.url + _parameters
        }
        _request.url = URL(string : self.url);
        
        for (key) in self.headers.keys {
            _request.addValue(self.headers[key]! ,forHTTPHeaderField: key)
           
        }
        var _ = session.dataTask(with: _request as URLRequest!){ data , response, error in
            if((error) == nil) {
                self.parser.parse(data : data, response : response);
            }
            completion(self.parser, error)
            }.resume()
    }
}


