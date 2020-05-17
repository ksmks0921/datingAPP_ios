//
//  message.swift
//  HappyDay
//
//  Created by Panda Star on 1/23/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation


class MessageItem {
    
    var chinese:String?
    var date: String?
    var english: String?
    var isseen: Bool?
    var japanese: String?
    var korean:String?
    var message: String?
    var receiver:String?
    var sender:String?
    var source_path: String?
    var source_type: String?
    var thumb_path: String?
    var time: String?

    
    
    init(chinese: String, date: String, english: String, isseen: Bool, japanese: String, korean: String, message: String, receiver: String, sender: String, source_path: String, source_type: String, thumb_path: String, time: String){
        
        self.chinese = chinese
        self.date = date
        self.english = english
        self.isseen = isseen
        self.japanese = japanese
        self.korean = korean
        self.message = message
        self.receiver = receiver
        self.sender = sender
        self.source_path = source_path
        self.source_type = source_type
        self.thumb_path = thumb_path
        self.time = time

    }
    
}
