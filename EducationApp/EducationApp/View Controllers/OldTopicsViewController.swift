//
//  TopicsViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

final class OldTopicsViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var topicsScroll: UIScrollView!
    @IBOutlet weak var topicsTableView: UITableView!
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        print("Style: ", style)
        print(self.tableView.style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(aDecoder)
        print(self.tableView.style)
    }
    
}

// MARK: - Life Cycle
extension OldTopicsViewController {
    
    // Called when the view is about to appear on screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
//        // Clean the scroll view. Wipe everything away
//        cleanTopicsScrollView()
//
//        // Reload the topics. Get them from the database.
//        getTopics()
    }
}

// MARK: - IBActions
private extension OldTopicsViewController {
    // What to do when the user seeks to log out.
    @IBAction func logOutPressed(_ sender: AnyObject) {
        PFUser.logOut()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Topics
private extension OldTopicsViewController { // populate the view with all of the topics
    
    func cleanTopicsScrollView() {
        // remove each of the entries in the scroll view
        for subview in topicsScroll.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func getTopics() {
        guard let query = Topic.query() else {
            return
        }
        
        query.findObjectsInBackground { [unowned self] objects, error in
            guard let objects = objects as? [Topic] else {
                self.showErrorView(error)
                return
            }
            self.loadTopicViews(objects)
        }
    }
    
    func loadTopicViews(_ objects: [Topic]) {
        cleanTopicsScrollView()
        
        // Need to keep a reference to the previous wall view for two reasons
        //
        // 1. It will be required for any future wall views so their topAnchor can be constrainted to the previous bottomAnchor
        // 2. At the end of the loop the bottom anchor for the previous topicsView must be constrained to the topicScroll's bottom
        //    anchor. Without this the scroll view could not automatically retrieve its content size from the
        var previousTopicView: UIView? = nil
        for topic in objects {
            print("Title: " + topic.name!)
            print("Details: " + topic.details!)
            let topicView = setupTopicView(previousTopicView)
            
            // Add the title label as subview to the **topicsView**
            let titleLabel = self.setupTitleLabel(topic.name, topicView: topicView)
            
            // Add the comment label as a subview to the **topicsView**
            self.setupDetailsLabel(topic.details, topicView: topicView, titleLabel: titleLabel)
            
            previousTopicView = topicView
        }
        
        // Always close out the constraints to the topicScroll bottomAnchor in order for the scrollView to
        // correctly calculate the contentSize variable from the auto layout constraints of its subviews
        previousTopicView?.bottomAnchor.constraint(equalTo: topicsScroll.bottomAnchor).isActive = true
    }
}

// MARK: - Other Private
// Mostly interface setup
private extension OldTopicsViewController {
    
    /**
     Method sets up a **UIView** to act as the **WallPost**'s view
     
     - parameter previousWallView: The previous wall view so the autolayout constraints can be set correctly
     this can be **nil** indicating this is the first wall view
     */
    func setupTopicView(_ previousTopicView: UIView?) -> UIView {
        let topicView = UIView()
        topicView.translatesAutoresizingMaskIntoConstraints = false
        topicsScroll.addSubview(topicView)
        
        // Generate the auto layout constraints required for the wallView
        topicView.heightAnchor.constraint(equalToConstant: 270.0).isActive = true
        topicView.leadingAnchor.constraint(equalTo: topicsScroll.leadingAnchor).isActive = true
        topicView.widthAnchor.constraint(equalTo: topicsScroll.widthAnchor).isActive = true
        
        // Generate to Y constraint based on if this is the first wallView object or not
        if let previousTopicView = previousTopicView {
            // Not the first wall view object so utilize the previous wall view objects bottom anchor
            topicView.topAnchor.constraint(equalTo: previousTopicView.bottomAnchor).isActive = true
        } else {
            // First wall view object so utilize the wallScroll objects topAnchor
            topicView.topAnchor.constraint(equalTo: topicsScroll.topAnchor).isActive = true
        }
        
        return topicView
    }
    
    /**
     Method creates and configures the **infoLabel** for the **WallPost**
     
     - parameter title: String of the name of the topic
     - parameter topicView: **UIView** associated with the topic view this will be the container
     view as well as the view to generate constraints from
     - returns: Configured **UILabel** used for topic information
     */
    func setupTitleLabel(_ title: String?, topicView: UIView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.sizeToFit()
        topicView.addSubview(label)
        
        // Generate the auto layout constraints required for the label
        label.leadingAnchor.constraint(equalTo: topicView.leadingAnchor, constant: 10.0).isActive = true
        label.trailingAnchor.constraint(equalTo: topicView.trailingAnchor, constant: 10.0).isActive = true
        label.topAnchor.constraint(equalTo: topicView.bottomAnchor, constant: 8.0).isActive = true
        
        return label
    }
    
    /**
     Method creates and configures the **commentLabel** for the **WallPost**
     
     - parameter comment: Comment the user made, can be **nil**
     - parameter wallView: **UIView** associated with the wall view this will be the container
     view as well as the view to generate constraints from
     - parameter infoLabel: used to generate constraints for Y placement inside the wallView
     */
    func setupDetailsLabel(_ details: String?, topicView: UIView, titleLabel: UILabel) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = details
        label.textColor = .white
        label.backgroundColor = .clear
        label.sizeToFit()
        topicView.addSubview(label)
        
        // Generate the auto layout constraints required for the label
        label.leadingAnchor.constraint(equalTo: topicView.leadingAnchor, constant: 10.0).isActive = true
        label.trailingAnchor.constraint(equalTo: topicView.trailingAnchor, constant: 10.0).isActive = true
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0).isActive = true
    }
}
