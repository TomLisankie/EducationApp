//
//  TopicsViewController.swift
//  
//
//  Created by Thomas Lisankie on 10/10/18.
//

import UIKit

class TopicsViewController: PFQueryTableViewController {
    
    override init(style: UITableView.Style, className: String?) {
        super.init(style: style, className: className)
        parseClassName = "Topic"
        pullToRefreshEnabled = false
        paginationEnabled = false
        objectsPerPage = 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parseClassName = "Topic"
        pullToRefreshEnabled = false
        paginationEnabled = false
        objectsPerPage = 50
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        let query = PFQuery(className: self.parseClassName!)
        
        if self.objects!.count == 0{
            
            query.cachePolicy = .cacheThenNetwork
            
        }
        
        return query
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PFTableViewCell
        
        if cell == nil{
            
            cell = PFTableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            
        }
        
        // Configure cell to show topic name and details
        if let object = object {
            cell!.textLabel?.text = object["name"] as? String
            cell!.detailTextLabel?.text = object["details"] as? String
            
        }
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("The Query Table View loaded")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Hello from the Segue")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello from the Tyap")
        self.performSegue(withIdentifier: "toSubTopics", sender: self)
        print("Finished the Tyap")
    }

}
