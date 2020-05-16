//
//  person.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation

class person {
    

    
    var required_age : String?
    var require_style : String?
    var require_tall : String?
    var style_1 : String?
    var style_2 : String?
    var style_3 : String?
    var style_4 : String?
    var user_age : String?
    var user_avatar : [String]?
    var user_blood : String?
    var user_city : String?
    var user_date : String?
    var user_email : String?
    var user_id : String?
    var user_introduce : String?
    var user_job : String?
    var user_lifestyle : String?
    var user_nickName : String?
    var user_outside : String?
    var user_sex : String?
    var user_star : String?
    var user_style : String?
    var user_tall : String?

    var user_status : String?
    
    
    init(required_age: String, require_style: String, require_tall: String, style_1: String, style_2: String, style_3: String, style_4: String, user_age: String, user_avatar: [String], user_blood: String, user_city: String, user_date: String, user_email: String, user_id: String, user_introduce: String, user_job: String, user_lifestyle: String, user_nickName: String, user_outside: String, user_sex: String, user_star: String, user_style: String, user_tall: String,  user_status: String)
    {
        self.required_age = required_age
        self.require_style = require_style
        self.require_tall = require_tall
        self.style_1 = style_1
        self.style_2 = style_2
        self.style_3 = style_3
        self.style_4 = style_4
        self.user_age = user_age
        self.user_avatar = user_avatar
        self.user_blood = user_blood
        self.user_city = user_city
        self.user_date = user_date
        self.user_email = user_email
        self.user_id = user_id
        self.user_introduce = user_introduce
        self.user_job = user_job
        self.user_lifestyle = user_lifestyle
        self.user_nickName = user_nickName
        self.user_outside = user_outside
        self.user_sex = user_sex
        self.user_star = user_star
        self.user_style = user_style
        self.user_tall = user_tall
       
        self.user_status = user_status
    }
    
}
