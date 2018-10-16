//
//  SubTopicViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 10/10/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

class SubTopicsViewController: UITableViewController {
    
    var parentTopicObject : PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subtopics = parentTopicObject?["subtopics"] as! [Any]
        return subtopics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let subtopics = parentTopicObject?["subtopics"] as! [Any]
        let subtopicInfo = subtopics[indexPath.row] as? [String : Any]
        cell.textLabel?.text = subtopicInfo?["name"] as? String
        print(subtopicInfo!["name"]!)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
        
        let subtopics = self.parentTopicObject?["subtopics"] as! [Any]
        
        let selected_subtopic = subtopics[indexPath.row] as! [String : Any]
        
        let destinationVC = segue.destination as? WebContentViewController
        
        destinationVC?.links = selected_subtopic["links"] as? [String : String]
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello from the Tyap 2")
        self.performSegue(withIdentifier: "toContentView", sender: self)
        print("Finished the Tyap 2")
    }

}
