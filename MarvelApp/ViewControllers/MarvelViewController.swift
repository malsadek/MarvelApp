//
//  MarvelViewController.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit

class MarvelViewController: UIViewController {
    
    let screenSize:CGRect = UIScreen.main.bounds
    var loader  = UIView();
    var actIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.frame = CGRect(x:0 ,y: 0,width : self.screenSize.width, height: self.screenSize.height )
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        actIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
        actIndicator.center = loader.center
        actIndicator.hidesWhenStopped = true
        actIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loader.addSubview(actIndicator)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func hideLoader() {
        self.actIndicator.stopAnimating()
        self.loader.removeFromSuperview()
    }
    
    func showLoader() {
        self.actIndicator.startAnimating()
        self.view.addSubview(self.loader)
        
    }
    func showAlert(title: String, message : String, completion: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) in
            completion();
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func dispatchRequest(request : Request, showLoader : Bool, foreground: ((_ : BaseParser,_ error: Error?) -> Void)! = nil, background: ((_ : BaseParser,_ error: Error?) -> Void)! = nil) {
        if(showLoader) {
            self.showLoader();
        }
        request.dataTask(completion : { (parser, error) -> Void in
            //            if(error == nil && parser.isDone() && (parser as! BaseParser).isSuccessful()) {
            //
            //            }
            
            if(showLoader) {
                DispatchQueue.main.async {
                    self.hideLoader();
                }
            }
            
            if(background != nil) {
                background(parser as! BaseParser, error)
            }
            if(error == nil) {
                func mycompletion(_ p : BaseParser,_ error: Error?) -> Void {
                    if(p.isSuccessful()) {
                        if(foreground != nil) {
                            DispatchQueue.main.async {
                                foreground(p, error);
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.handleError(p, error, foreground);
                        }
                    }
                }
                let p : BaseParser = parser as! BaseParser;
                mycompletion(p, error);
                
            }
            else {
                if(showLoader) {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message : "Connection Problem", completion: {
                            if(foreground != nil) {
                                foreground(parser as! BaseParser, error);
                            }
                        })
                    }
                }
            }
            
        });
        
    }
    
    func handleError(_ parser : BaseParser, _ error : Error?, _ foreground: ((_ : BaseParser,_ error: Error?) -> Void)! = nil) {
        //handle errors based on code
        //        let code : Int = parser.code;
        
        return
    }
}

