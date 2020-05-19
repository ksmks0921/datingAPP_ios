//
//  alarm.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/19/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation

class alarm {
    
     var title : String?
     var content : String?
     var time : String?
    
    init(title: String, content: String, time:String) {
        self.title = title
        self.content = content
        self.time = time
    }
}
