//
//  SampleTopicData.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/27/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import Foundation
final class SampleData{
    
    static func generateTopicData() -> [Topic] {
        
        return [
            Topic(name: "Data Structures", description: "Learn about the basic data structures in Computer Science"),
            Topic(name: "Statistics", description: "Learn basic statistics concepts important to Data Science")
        ]
        
    }
    
}
