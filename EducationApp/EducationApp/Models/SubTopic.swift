//
//  SubTopic.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 10/8/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import Foundation

class SubTopic : PFObject {
    
    //MARK: Properties
    @NSManaged var name: String?
    @NSManaged var links: [String: String]?
    
    //MARK: Initializers
    init(name: String, links: [String: String]) {
        
        super.init()
        self.name = name
        self.links = links
    }
    
    //MARK: Overridden
    override class func query() -> PFQuery<PFObject>? {
        
        let query = PFQuery(className: SubTopic.parseClassName())
        query.includeKey("user")
        return query
        
    }
    
}

extension SubTopic : PFSubclassing {
    
    static func parseClassName() -> String {
        
        return "SubTopic"
        
    }
    
}

