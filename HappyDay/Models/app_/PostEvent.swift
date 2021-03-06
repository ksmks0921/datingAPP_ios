//
//  PostEvent.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation


struct PostEvent {
    
    var user_avatar: String!
    var event_type: String!
    var view_counts: String
    var nick_name: String!
    var age: String!
    var region: String!
    var event_des: String!
    var thumb_path: String!
    var gender: Bool!
    var source_type: String!
    var user_tall : String!
    var user_style : String!
    var user_job : String!
    var user_id : String!
    var created_at : Int!
    var event_photo : String!
    var event_city: String!
    var event_phone : String!
    var user_city : String!
    var row_key : String!
    var created_date: String!
    init(user_avatar: String, event_type:String, view_counts: String, nick_name: String, age: String, region: String,  event_des: String, thumb_path: String, user_gender: Bool, source_type: String, user_tall: String, user_style: String, user_job: String, user_id: String, created_at: Int ,event_photo : String, event_city: String, event_phone : String, user_city : String, row_key : String, created_date: String){
        
        self.user_avatar    = user_avatar
        self.event_type     = event_type
        self.view_counts    = view_counts
        self.nick_name      = nick_name
        self.age            = age
        self.region         = region
        self.event_des      = event_des
        self.thumb_path     = thumb_path
        self.gender         = user_gender
        self.source_type    = source_type
        self.user_tall      = user_tall
        self.user_style     = user_style
        self.user_job       = user_job
        self.user_id        = user_id
        self.created_at     = created_at
        self.event_photo    = event_photo
        self.event_city     = event_city
        self.event_phone    = event_phone
        self.user_city      = user_city
        self.row_key        = row_key
        self.created_date   = created_date
    }
    
    
}
