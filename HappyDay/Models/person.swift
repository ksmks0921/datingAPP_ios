//
//  person.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation

class person {
    
    var id:Int?
    var name: String?
    var avatar: String?
    var desc: String?
    var gender:String?
    var about_gender: String?
    var live_place: String?
    var age:String?
    var body:String?
    var style: String?
    var job: String?
    var interest: String?
    var is_favorite: Bool?
    var last_message: String?
    var has_new: Bool?
    var aboutMe: String?
    var photos: Int?
    var birthday: String?
    var nickName: String?
    
    
    init(id: Int, name: String, avatar: String, photos: Int, birthday: String, about_gender: String, live_place: String, aboutMe: String, gender: String, age: String, nickName: String)
    {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.photos = photos
        self.birthday = birthday
        
        self.about_gender = about_gender
        self.live_place = live_place
        self.aboutMe = aboutMe
        self.gender = gender
        self.age = age
        self.nickName = nickName
    }
    
}
