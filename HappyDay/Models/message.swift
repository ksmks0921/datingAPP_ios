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
    var name: String?
    var photo: String?
    var desc: String?
    var gender:String?
    var born_place: String?
    var age:Int?
    var body:String?
    var style: String?
    var job: String?
    var last_message: String?
    var has_new: Bool?
    var is_favorite: Bool?
    
    init(name: String, photo: String, last_message: String, is_favorite: Bool, has_new: Bool){
        
        self.last_message = last_message
        self.name = name
        self.photo = photo
        self.is_favorite = is_favorite
        self.has_new = has_new

    }
    
}
