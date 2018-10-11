//
//  Topic.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/27/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import Foundation

class Topic : PFObject {
    
    //MARK: Properties
    @NSManaged var name: String?
    @NSManaged var details: String?
    @NSManaged var subTopics: [SubTopic]? //Need to change this to match with db structure
    
    //MARK: Initializers
    init(name: String, details: String) {
    
        super.init()
        self.name = name
        self.details = details
        
    }
    
    // Required otherwise the application crashes
    override init() {
        super.init()
    }
    
    //MARK: Overridden
    override class func query() -> PFQuery<PFObject>? {
        
        let query = PFQuery(className: Topic.parseClassName())
        return query
        
    }
    
}

extension Topic : PFSubclassing {
    
    static func parseClassName() -> String {
        
        return "Topic"
        
    }
    
}
