//
//  message.swift
//  HappyDay
//
//  Created by Panda Star on 1/23/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation


class message {
    
    var id:Int?
    var friend_id: Int?
    var name: String?
    var photo: String?
    var desc: String?
    var gender:String?
    var location: String?
    var age:String?
    var body:String?
    var style: String?
    var job: String?
    var last_message: String?
    var has_new: Bool?
    var is_favorite: Bool?
    var time: String?
    
    
    init(friend_id: Int, name: String, photo: String, age: String, location: String, time: String, last_message: String, is_favorite: Bool, has_new: Bool){
        
        self.friend_id = friend_id
        self.name = name
        self.photo = photo
        self.age = age
        self.location = location
        self.time = time
        self.is_favorite = is_favorite
        self.has_new = has_new
        self.last_message = last_message

    }
    
}
