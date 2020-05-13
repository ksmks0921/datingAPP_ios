//
//  Section.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
import Foundation

struct Section {
    
    var title: String!
    var items: [String]!
    var values: [String]!

    
    
    init(title: String, items:[String], values: [String]){
        
        self.title = title
        self.items = items       
        self.values = values
    }
}
