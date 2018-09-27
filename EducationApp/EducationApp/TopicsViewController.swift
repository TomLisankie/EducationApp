//
//  TopicsViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

class TopicsViewController: UITableViewController {
    
    //MARK: Properties
    var topics = SampleData.generateTopicData()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
}

//MARK: UITableViewDataSource
extension TopicsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        let topic = topics[indexPath.row]
        cell.textLabel?.text = topic.name
        cell.detailTextLabel?.text = topic.description
        return cell
    }
    
}
