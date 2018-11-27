//
//  MainViewController.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit

class MainViewController: MarvelViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    
    let cellIdentifier = "cell"
    var marvelCharacters =  [MarvelCharacter]()
    var count = 0
    var limit = 0
    //    var offset = 0
    var total = 0
    var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.charactersTableView.delegate = self
        self.charactersTableView.dataSource = self
        self.charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.spinner = UIActivityIndicatorView(style: .gray)
        self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: self.charactersTableView.frame.width, height: 50.0)
        self.getCharacters()
        
    }
    
    func getCharacters(){
        self.charactersTableView.tableFooterView = self.spinner
        self.spinner.startAnimating()
        let request = MarvelRequests.sharedInstance.characters(offset: self.count)
        self.dispatchRequest(
            request : request,
            showLoader: (self.count == 0),
            foreground : {(p, e) -> Void in
                if e == nil && p.isSuccessful() {
                    let parser : CharacterParser = p as! CharacterParser ;
                    self.marvelCharacters.append(contentsOf: parser.getResults())
                    self.count += parser.getCount()
                    self.limit = parser.getLimit()
                    //                    self.offset = parser.getOffset()
                    self.total = parser.getTotal()
                    self.spinner.stopAnimating()
                    self.charactersTableView.tableFooterView = UIView()
                    self.charactersTableView.reloadData()
                    
                }
        },
            background : {(p, e) -> Void in
                
        });
    }
}

//MARK: - Tableview delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.marvelCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let marvelChar = self.marvelCharacters[indexPath.row]
        cell.textLabel?.text =  marvelChar.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //present details
        let marvelChar = self.marvelCharacters[indexPath.row]

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.marvelCharacters.count - 1) {
            if self.count < self.total {
                self.getCharacters()
            }
        }
    }
}
