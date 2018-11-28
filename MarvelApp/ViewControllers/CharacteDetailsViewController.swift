//
//  CharacteDetailsViewController.swift
//  MarvelApp
//
//  Created by Mariam Al Sadek on 11/27/18.
//  Copyright © 2018 Mariam Sadek. All rights reserved.
//

import UIKit

class CharacteDetailsViewController: MarvelViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var character: MarvelCharacter!
    var cellIdentifier = "detailCell"
    var info = Dictionary<String, [MarvelItem]>()
    let sectionTitles = ["Comics", "Events","Stories","Series"]
    let viewLimit = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
        
        self.navigationItem.title = "\(self.character.id) \(self.character.name)"
        
        self.info = Dictionary(dictionaryLiteral: (sectionTitles[0], self.character.comics),(sectionTitles[1], self.character.events), (sectionTitles[2], self.character.stories), (sectionTitles[3], self.character.series))
       
        let infoCount = character.comics.count + character.series.count + character.events.count + character.stories.count
        if infoCount == 0 {
            //No data to show
            let noData = UILabel(frame: self.tableView.frame)
            noData.text = "No Data Found"
            noData.textAlignment = .center
            self.view.addSubview(noData)
        }
        self.imageView.imageFromURL(urlString: character?.thumbnail.urlString ?? "")
        // Do any additional setup after loading the view.
    }
    
    
}
extension CharacteDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  (self.info[sectionTitles[section]]?.count ?? 0 > 0 ) ? self.sectionTitles[section] : nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return min(self.info[sectionTitles[section]]?.count ?? 0, viewLimit)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let marvelItem = self.info[sectionTitles[indexPath.section]]?[indexPath.row]
        cell.textLabel?.text = marvelItem?.name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
    
    
}

