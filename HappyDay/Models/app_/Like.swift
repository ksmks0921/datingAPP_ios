//
//  Like.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation

class Like {
    
    var like_age        : String!
    var like_avatar     : String!
    var like_city       : String!
    var like_date       : String!
    var like_id         : String!
    var like_info       : String!
    var like_name       : String!
    var user_sex        : Bool!
   

    
    
    init(like_age: String, like_avatar:String, like_city:String, like_date:String, like_id:String, like_info:String, like_name:String, user_sex: Bool){
        
        self.like_age = like_age
        self.like_avatar = like_avatar
        self.like_city = like_city
        self.like_date = like_date
        self.like_id = like_id
        self.like_info = like_info
        self.like_name = like_name
        self.user_sex = user_sex
        
    }
}
