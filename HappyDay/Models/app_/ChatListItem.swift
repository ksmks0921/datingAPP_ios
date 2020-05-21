//
//  ChatListItem.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//


import Foundation


class ChatListItem {
    
    var avatar: String!
    var nick_name: String!
    var age: String!
    var region: String!
    var last_message: String!
    var last_connect_time: String!
    var last_connect_date: String!
    var id : String!
    var chats: [MessageItem]!
    
    init(avatar: String, nick_name:String,  age:String, region:String, last_message:String, last_connect_time:String, last_connect_date: String, id: String, chats: [MessageItem]){
        
        self.avatar             = avatar
        self.nick_name          = nick_name
        self.age                = age
        self.region             = region
        self.last_message       = last_message
        self.last_connect_time  = last_connect_time
        self.last_connect_date  = last_connect_date
        self.id                 = id
        self.chats              = chats
    }
}

