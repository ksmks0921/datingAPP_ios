//
//  UserVM.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

typealias responseCallBack = ((Bool, String?, NSError?) -> ())


class UserVM {
    private init(){}
    static let shared = UserVM()
    static var users = [person]()
    static var search_result = [person]()
    static var eventPosts = [PostEvent]()
    static var my_eventPosts = [PostEvent]()
    static var filtered_eventPosts = [PostEvent]()
    
    static var likes    = [Like]()  // used same class "Like" for likes , ignores, blocks and memos
    static var memos    = [Like]()
    static var ignores  = [Like]()
    static var blocks   = [Like]()
    
    static var current_user: person!
    let ref : DatabaseReference = Database.database().reference()
    static var user_points: Int!
    
    func AnonymousLogin (response: @escaping responseCallBack) {
        
        Auth.auth().signInAnonymously() { (result, error) in
            
           if let error = error {
               print("error________________")
               print(error.localizedDescription)
               return
           }
           
           response(true, "OK", nil)

        }
        
        
    }
    
    func likeUser(like_age: String, like_avatar: String, like_city: String, like_date: String, like_id: String, like_info: String, like_name: String, like_sex: String, response: @escaping responseCallBack) {
        
        let updateUser = [  FireBaseConstant.lAge           : like_age,
                            FireBaseConstant.lAvatar        : like_avatar,
                            FireBaseConstant.lCity          : like_city,
                            FireBaseConstant.lDate          : like_date,
                            FireBaseConstant.lID            : like_id,
                            FireBaseConstant.lInfo          : like_info,
                            FireBaseConstant.lName          : like_name,
                            FireBaseConstant.lSex           : like_sex
                           
        ]
        self.ref.child(FireBaseConstant.Likes).child(DataManager.userId!).child(like_id).setValue(updateUser)
        response(true, "success", nil)
    }
    
    
    func login(email: String, password: String, response: @escaping responseCallBack){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            Indicator.sharedInstance.hideIndicator()
            if error == nil{
                let user_id = email.replacingOccurrences(of: "@", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
                DataManager.userId = user_id
                DataManager.email = user?.user.email
//
//                self.ref.child(FireBaseConstant.UserNode).child(user_id).observe(.value) {  (snapShot) in
//                    let user_snap = snapShot as? NSDictionary
//
//
//                }
                response(true, "Login Successfully.", nil)
            }else{
                response(false, error?.localizedDescription, nil)
            }
        }
    }
    func updateUserData(city: String,age: String, job: String, blood: String, star: String, tall: String,user_style: String, life_style: String, user_outside: String, sex: Bool, nick_name: String, style_1: String, style_2 : String, style_3: String, style_4: String,require_age: String, is_approved:String, updated_at: String, created_at: String, require_style: String, require_tall: String, status: String, introduce: String, date: String, user_avatar: [String], response: @escaping responseCallBack){
        
        
        let updateUserAvatar = [FireBaseConstant.kUserAvatar1 : user_avatar[0],
                                FireBaseConstant.kUserAvatar2 : user_avatar[1],
                                FireBaseConstant.kUserAvatar3 : user_avatar[2],
        ]

        let updateUser = [FireBaseConstant.kEmail     : DataManager.email!,
                      FireBaseConstant.kCity          : city,
                      FireBaseConstant.kAge           : age,
                      FireBaseConstant.kUserID        : DataManager.userId!,
                      FireBaseConstant.kUserAvatar    : updateUserAvatar,
                      FireBaseConstant.kUserJob       : job,
                      FireBaseConstant.kUserPassword  : "",
                      FireBaseConstant.kUserBlood     : blood,
                      FireBaseConstant.kUserDate      : date,
                      FireBaseConstant.kUserStar      : star,
                      FireBaseConstant.kUserTall      : tall,
                      FireBaseConstant.kUserStyle     : user_style,
                      FireBaseConstant.kUserIntroduce : introduce,
                      FireBaseConstant.kUserLifeStyle : life_style,
                      FireBaseConstant.kUserOutside   : user_outside,
                      FireBaseConstant.kUserSex       : sex,
                      FireBaseConstant.kUserNickName  : nick_name,
                      FireBaseConstant.kStatus        : status,
                      FireBaseConstant.kStyle1        : style_1,
                      FireBaseConstant.kStyle2        : style_2,
                      FireBaseConstant.kStyle3        : style_3,
                      FireBaseConstant.kStyle4        : style_4,
                      FireBaseConstant.kCreatedAt     : Int(created_at)!,
                      FireBaseConstant.kUpdatedAt     : Int(updated_at)!,
                      FireBaseConstant.kIsApproved    : is_approved,
                      FireBaseConstant.kRequireAge    : require_age,
                      FireBaseConstant.kRequireStyle  : require_style,
                      FireBaseConstant.kRequireTall   : require_tall
            ] as [String : Any]
            self.ref.child(FireBaseConstant.UserNode).child(DataManager.userId!).setValue(updateUser)
            response(true, "Registered Successfully.", nil)
    }
    func singUp(email: String, password: String, city: String, gender: Bool, age: String,  response: @escaping responseCallBack){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                DataManager.userId = user?.user.uid
                DataManager.email = user?.user.email
                
                let user_id = email.replacingOccurrences(of: "@", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
                let updateUser = [FireBaseConstant.kEmail         : DataManager.email!,
                                  FireBaseConstant.kCity          : city,
                                  FireBaseConstant.kAge           : age,
                                  FireBaseConstant.kUserID        : user_id,
                                  FireBaseConstant.kUserAvatar    : "",
                                  FireBaseConstant.kUserJob       : "",
                                  FireBaseConstant.kUserPassword  : "",
                                  FireBaseConstant.kUserBlood     : "",
                                  FireBaseConstant.kUserDate      : "",
                                  FireBaseConstant.kUserStar      : "",
                                  FireBaseConstant.kUserTall      : "",
                                  FireBaseConstant.kUserStyle     : "",
                                  FireBaseConstant.kUserIntroduce : "",
                                  FireBaseConstant.kUserLifeStyle : "",
                                  FireBaseConstant.kUserOutside   : "",
                                  FireBaseConstant.kUserSex       : String(gender),
                                  FireBaseConstant.kUserNickName  : "",
                                  FireBaseConstant.kStatus        : "",
                                  FireBaseConstant.kStyle1        : "",
                                  FireBaseConstant.kStyle2        : "",
                                  FireBaseConstant.kStyle3        : "",
                                  FireBaseConstant.kStyle4        : "",
                                  FireBaseConstant.kCreatedAt     : 0,
                                  FireBaseConstant.kUpdatedAt     : 0,
                                  FireBaseConstant.kIsApproved    : "",
                                  FireBaseConstant.kRequireAge    : "",
                                  FireBaseConstant.kRequireStyle  : "",
                                  FireBaseConstant.kRequireTall   : ""
                    ] as [String : Any]
                self.ref.child(FireBaseConstant.UserNode).child(user_id).setValue(updateUser)
                response(true, "Registered Successfully.", nil)
            }else{
                response(false, error?.localizedDescription, nil)
            }
        }
        
    }
    
    func getUsers(completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.UserNode).observe(.value) { (snapShot) in

               let children = snapShot.children
               UserVM.users.removeAll()
               while let rest = children.nextObject() as? DataSnapshot {
                   if let restDict = rest.value as? NSDictionary{
                            let user_id = restDict[FireBaseConstant.kUserID] as? String
                    
                            let required_age = restDict[FireBaseConstant.kRequireAge] as? String
                            let require_style = restDict[FireBaseConstant.kRequireStyle] as? String
                            let require_tall = restDict[FireBaseConstant.kRequireTall] as? String
                            let style_1 = restDict[FireBaseConstant.kStyle1] as? String
                            let style_2 = restDict[FireBaseConstant.kStyle2] as? String
                            let style_3 = restDict[FireBaseConstant.kStyle3] as? String
                            let style_4 = restDict[FireBaseConstant.kStyle4] as? String
                            let user_age = restDict[FireBaseConstant.kAge] as? String
                    
                    
                           
                            var user_avatar_list = [String]()
                            if let user_avatar = restDict[FireBaseConstant.kUserAvatar] as? NSDictionary {
                               
                                let user_avatar_1 = user_avatar[FireBaseConstant.kUserAvatar1] as? String ?? ""
                                let user_avatar_2 = user_avatar[FireBaseConstant.kUserAvatar2] as? String ?? ""
                                let user_avatar_3 = user_avatar[FireBaseConstant.kUserAvatar3] as? String ?? ""
                               
                                user_avatar_list = [user_avatar_1, user_avatar_2, user_avatar_3]
                            }
                    
                    
                            let user_blood = restDict[FireBaseConstant.kUserBlood] as? String
                            let user_city = restDict[FireBaseConstant.kCity] as? String
                            let user_date = restDict[FireBaseConstant.kUserDate] as? String
                            let user_email = restDict[FireBaseConstant.kEmail] as? String
                            
                            let user_introduce = restDict[FireBaseConstant.kUserIntroduce] as? String
                            let user_job = restDict[FireBaseConstant.kUserJob] as? String
                            let user_lifestyle = restDict[FireBaseConstant.kUserLifeStyle] as? String
                            let user_nickName = restDict[FireBaseConstant.kUserNickName] as? String
                            let user_outside = restDict[FireBaseConstant.kUserOutside] as? String
                            let is_approved = restDict[FireBaseConstant.kIsApproved] as? String
                            
                            let updated_at = restDict[FireBaseConstant.kUpdatedAt] as? Int
                            let created_at = restDict[FireBaseConstant.kCreatedAt] as? Int
                   
                            let user_sex : String!
                          
                           
                            if (restDict[FireBaseConstant.kUserSex] as? Bool)! {
                                user_sex = "남자"
                            }
                            else {
                                user_sex = "녀자"
                            }
                            let user_star = restDict[FireBaseConstant.kUserStar] as? String
                            let user_style = restDict[FireBaseConstant.kUserStyle] as? String
                            let user_tall = restDict[FireBaseConstant.kUserTall] as? String
                            
                            let user_status = restDict[FireBaseConstant.kStatus] as? String
                    let person_item = person(required_age: required_age!, require_style: require_style!, require_tall: require_tall!, style_1: style_1!, style_2: style_2!, style_3: style_3!,  style_4: style_4!, user_age: user_age!, user_avatar: user_avatar_list, user_blood: user_blood!, user_city: user_city!, user_date: user_date!, user_email: user_email!, user_id: user_id!, user_introduce : user_introduce!,user_job: user_job!, user_lifestyle: user_lifestyle!, user_nickName: user_nickName!, user_outside: user_outside!, user_sex: user_sex!, user_star: user_star!, user_style: user_style!, user_tall: user_tall!,  user_status : user_status!, is_approved: is_approved!, updated_at: String(updated_at!), created_at: String(created_at!))
                            if person_item.user_id == DataManager.userId {
                                UserVM.current_user = person_item
                            }
                            else {
                                UserVM.users.append(person_item)
                            }
                            
                    

                   }
                  
            }
            
             completion(true)
        }
    
        
        
        
    }
    
    
    func search(sex : String, city: String, age: String, tall: String, style: String, job: String, nick_name: String, completion: @escaping (Bool) -> Void) {
       
        UserVM.search_result = UserVM.users
        
        if sex != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "sex", value: sex)
        }
        if city != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "city", value: city)
        }
        if age != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "age", value: age)
        }
        if tall != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "tall", value: tall)
        }
        if style != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "style", value: style)
        }
        if job != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "job", value: job)
        }
        if nick_name != AppConstant.eAll {
            UserVM.search_result = filterUsesrs(init_data: UserVM.search_result, key: "nick_name", value: nick_name)
        }
       
        completion(true)
        
    }
    
    func filterUsesrs(init_data: [person], key: String, value: String) -> [person] {
        var result = [person]()
        if key == "sex" {
            for item in init_data {
                
                
                if item.user_sex == value  {
                    result.append(item)
                }
                
            }
            
        }
        if key == "city" {
            for item in init_data {
                
                
                if item.user_city == value  {
                    result.append(item)
                }
                
            }
           
        }
        if key == "age" {
            for item in init_data {
                
                
                if item.user_age == value  {
                    result.append(item)
                }
                
            }
           
        }
        if key == "tall" {
            for item in init_data {
                
                
                if item.user_tall == value  {
                    result.append(item)
                }
                
            }
           
        }
        if key == "style" {
            for item in init_data {
                
                
                if item.user_style == value  {
                    result.append(item)
                }
                
            }
           
        }
        if key == "job" {
            for item in init_data {
                
                
                if item.user_job == value  {
                    result.append(item)
                }
                
            }
           
        }
        return result
    }
    
    func getEventPosts(completion: @escaping (Bool) -> Void){
        
        ref.child(FireBaseConstant.Events).observe(.value) { (snapShot) in
            let children = snapShot.children
            UserVM.eventPosts.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{
                    
                    let user_avatar = restDict[FireBaseConstant.EventUserAvatar] as? String
                    let event_type = restDict[FireBaseConstant.EventType] as? String
                    let view_counts = restDict[FireBaseConstant.view_counts] as? String
                    let nick_name = restDict[FireBaseConstant.EventUserName] as? String
                    
                    let age = restDict[FireBaseConstant.EventUserAge] as? String
                    let region = restDict[FireBaseConstant.EventUserCity] as? String
                    let gender = restDict[FireBaseConstant.EventUserGender] as? Bool
                   
                    let event_des = restDict[FireBaseConstant.EventDes] as? String
                    let thumb_path = restDict[FireBaseConstant.thumb_path] as? String
                    let source_type = restDict[FireBaseConstant.source_type] as? String
                    let user_tall = restDict[FireBaseConstant.EventUserTall] as? String
                    let user_style = restDict[FireBaseConstant.EventUserStyle] as? String
                    let user_job = restDict[FireBaseConstant.EventUserJob] as? String
                    let user_id = restDict[FireBaseConstant.EventUserID] as? String
                    
                    let post_item = PostEvent(user_avatar: user_avatar!, event_type: event_type!, view_counts: view_counts!, nick_name: nick_name!, age: age!, region: region!, event_des: event_des!, thumb_path: thumb_path!, user_gender: gender!, source_type: source_type!, user_tall: user_tall!, user_style: user_style!, user_job: user_job!, user_id: user_id!)
                    UserVM.eventPosts.append(post_item)

                    
                }
            }
        
        completion(true)
        }
        
    }
    func getMyEventPosts(completion: @escaping (Bool) -> Void){
        
        ref.child(FireBaseConstant.Events).observe(.value) { (snapShot) in
            let children = snapShot.children
            UserVM.my_eventPosts.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{
                    
                    let user_avatar = restDict[FireBaseConstant.EventUserAvatar] as? String
                    let event_type = restDict[FireBaseConstant.EventType] as? String
                    let view_counts = restDict[FireBaseConstant.view_counts] as? String
                    let nick_name = restDict[FireBaseConstant.EventUserName] as? String
                    
                    let age = restDict[FireBaseConstant.EventUserAge] as? String
                    let region = restDict[FireBaseConstant.EventUserCity] as? String
                    let gender = restDict[FireBaseConstant.EventUserGender] as? Bool
                   
                    let event_des = restDict[FireBaseConstant.EventDes] as? String
                    let thumb_path = restDict[FireBaseConstant.thumb_path] as? String
                    let source_type = restDict[FireBaseConstant.source_type] as? String
                    let user_tall = restDict[FireBaseConstant.EventUserTall] as? String
                    let user_style = restDict[FireBaseConstant.EventUserStyle] as? String
                    let user_job = restDict[FireBaseConstant.EventUserJob] as? String
                    let user_id = restDict[FireBaseConstant.EventUserID] as? String
                    
                    let post_item = PostEvent(user_avatar: user_avatar!, event_type: event_type!, view_counts: view_counts!, nick_name: nick_name!, age: age!, region: region!, event_des: event_des!, thumb_path: thumb_path!, user_gender: gender!, source_type: source_type!, user_tall: user_tall!, user_style: user_style!, user_job: user_job!, user_id: user_id!)
                    if post_item.user_id == DataManager.userId {
                        UserVM.my_eventPosts.append(post_item)
                    }
                    

                    
                }
            }
        
        completion(true)
        }
        
    }
    func filterEvents(location: String, type: String, source_type: String, age: String, tall: String, style: String, job: String, nick_name: String, completion: @escaping (Bool) -> Void){
        UserVM.filtered_eventPosts = UserVM.eventPosts
        if location != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.EventCity, value: location)
        }
        if type != AppConstant.eAll {
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.EventType, value: type)
        }
        if source_type != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.source_type, value: source_type)
        }
        if age != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.kAge, value: age)
        }
        if tall != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.kUserTall, value: tall)
        }
        if style != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.kUserStyle, value: style)
        }
        if job != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.kUserJob, value: job)
        }
        if nick_name != AppConstant.eAll {
        
            UserVM.filtered_eventPosts = doFilter(init_data: UserVM.filtered_eventPosts , key: FireBaseConstant.kUserNickName, value: nick_name)
        }
        completion(true)
    }
    
    func doFilter(init_data: [PostEvent], key: String, value: String) -> [PostEvent]  {
        
            var result = [PostEvent]()
            if key == FireBaseConstant.EventCity {
                for item in init_data {
                    
                    
                    if item.region == value  {
                        result.append(item)

                    }
                    
                }
            }
            if key == FireBaseConstant.EventType {
                for item in init_data {
                    
                    
                    if item.event_type == value  {
                        result.append(item)
                    }
                    
                }
                
            }
            if key == FireBaseConstant.source_type {
                for item in init_data {
                    
                    
                    if item.source_type == value  {
                        result.append(item)

                    }
                    
                }
            }
            
            if key == FireBaseConstant.kAge {
                for item in init_data {
                    
                    
                    if item.age == value  {
                        result.append(item)

                    }
                    
                }
            }
        if key == FireBaseConstant.kUserTall {
            for item in init_data {
                
                
                if item.user_tall == value  {
                    result.append(item)

                }
                
            }
        }
        if key == FireBaseConstant.kUserStyle {
            for item in init_data {
                
                
                if item.user_style == value  {
                    result.append(item)

                }
                
            }
        }
        if key == FireBaseConstant.kUserJob {
            for item in init_data {
                
                
                if item.user_job == value  {
                    result.append(item)

                }
                
            }
        }
        if key == FireBaseConstant.kUserNickName {
            for item in init_data {
                
                
                if item.nick_name == value  {
                    result.append(item)

                }
                
            }
        }
        
        
        return result
        
    }
    
    func registerEvent(event_city: String, create_date: String, event_des: String, event_phone: String, event_title: String, event_type: String, user_age:String, user_avatar: String, user_city: String, user_gender: Bool, user_job: String, user_name: String, user_style: String, user_tall: String, user_id: String, created_at: String, row_key: String, source_type: String, thumb_path: String, views_counts: String,  response: @escaping responseCallBack){
        
        let newEvent = [FireBaseConstant.EventCity                : event_city,
                        FireBaseConstant.EventCreatedDate         : create_date,
                        FireBaseConstant.EventDes                 : event_des,
                        FireBaseConstant.EventPhone               : event_phone,
                        FireBaseConstant.EventTitle               : event_title,
                        FireBaseConstant.EventType                : event_type,
                        FireBaseConstant.EventUserAge             : user_age,
                        FireBaseConstant.EventUserAvatar          : user_avatar,
                        FireBaseConstant.EventUserCity            : user_city,
                        FireBaseConstant.EventUserGender          : user_gender,
                        FireBaseConstant.EventUserJob             : user_job,
                        FireBaseConstant.EventUserName            : user_name,
                        FireBaseConstant.EventUserStyle           : user_style,
                        FireBaseConstant.EventUserTall            : user_tall,
                        FireBaseConstant.EventUserID              : user_id,
                        FireBaseConstant.created_at               : created_at,
                        FireBaseConstant.row_key                  : row_key,
                        FireBaseConstant.source_type              : source_type,
                        FireBaseConstant.thumb_path               : thumb_path,
                        FireBaseConstant.view_counts              : views_counts
            ] as [String : Any]
        self.ref.child(FireBaseConstant.Events).child(user_id).setValue(newEvent)
        response(true, "Registered Successfully.", nil)
        
    }
    
    func sendMessage(sender_id: String, receiver_id: String, text: String, sourceType: String, sourcePath: String, thumb_path: String, time: String, date: String,  response: @escaping responseCallBack) {
        
        let newMessage = [    FireBaseConstant.lang_chinese                 : "",
                              FireBaseConstant.lang_korean                  : "",
                              FireBaseConstant.lang_japanese                : "",
                              FireBaseConstant.lang_english                 : "",
                              FireBaseConstant.mdate                        : date,
                              FireBaseConstant.misseen                      : false,
                              FireBaseConstant.message                      : text,
                              FireBaseConstant.mreceiver                    : receiver_id,
                              FireBaseConstant.msender                      : sender_id,
                              FireBaseConstant.msource_path                 : sourcePath,
                              FireBaseConstant.msource_type                 : sourceType,
                              FireBaseConstant.mthumb_path                  : thumb_path,
                              FireBaseConstant.mtime                        : time
                    
         ] as [String : Any]
        
        self.ref.child(FireBaseConstant.Chats).childByAutoId().setValue(newMessage)
        
        
        let newChatList = [ FireBaseConstant.l_id       : receiver_id,
                            FireBaseConstant.l_status   : "add"
        ]
       
        self.ref.child(FireBaseConstant.Chatlist).child(sender_id).child(receiver_id).setValue(newChatList)
        response(true, "sent Successfully.", nil)
    }
    
    func getPoint(user_id: String, completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.Points).child(user_id).child(FireBaseConstant.p_point).observe(.value) { (snapShot) in

            let value = snapShot.value as! Int
            UserVM.self.user_points = value
                completion(true)
        }
    }
    
    func getLikes(user_id: String, completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.Likes).child(user_id).observe(.value) { (snapShot) in

            let children = snapShot.children
            UserVM.likes.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{

                        let like_age = restDict[FireBaseConstant.LikeAge] as? String
                        let like_avatar = restDict[FireBaseConstant.LikeAvatar] as? String
                        let like_city = restDict[FireBaseConstant.LikeCity] as? String
                        let like_date = restDict[FireBaseConstant.LikeDate] as? String
                        let like_id = restDict[FireBaseConstant.LikeID] as? String
                        let like_info = restDict[FireBaseConstant.LikeInfo] as? String
                        let like_name = restDict[FireBaseConstant.LikeName] as? String
                        let user_sex = restDict[FireBaseConstant.UserSex] as? Bool
                    
                    let like_item = Like(like_age: like_age!, like_avatar:like_avatar!, like_city:like_city!, like_date:like_date!, like_id:like_id!, like_info:like_info!, like_name:like_name!, user_sex: user_sex!)
                        
                        UserVM.likes.append(like_item)
                    
                    }

            }
            completion(true)
        }
    }
    func getMemos(user_id: String, completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.Memos).child(user_id).observe(.value) { (snapShot) in

            let children = snapShot.children
            UserVM.memos.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{

                        let memo_age = restDict[FireBaseConstant.MemoAge] as? String
                        let memo_avatar = restDict[FireBaseConstant.MemoAvatar] as? String
                        let memo_city = restDict[FireBaseConstant.MemoCity] as? String
                        let memo_date = restDict[FireBaseConstant.MemoDate] as? String
                        let memo_id = restDict[FireBaseConstant.MemoID] as? String
                        let memo_info = restDict[FireBaseConstant.MemoInfo] as? String
                        let memo_name = restDict[FireBaseConstant.MemoName] as? String
                        let user_sex = restDict[FireBaseConstant.MemoUserSex] as? Bool
                    
                    let memo_item = Like(like_age: memo_age!, like_avatar: memo_avatar!, like_city: memo_city!, like_date: memo_date!, like_id: memo_id!, like_info: memo_info!, like_name: memo_name!, user_sex: user_sex!)
                        
                        UserVM.memos.append(memo_item)
                    
                    }

            }
            completion(true)
        }
    }
    func getIgnores(user_id: String, completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.Ignores).child(user_id).observe(.value) { (snapShot) in

            let children = snapShot.children
            UserVM.ignores.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{

                        let ignore_age = restDict[FireBaseConstant.IgnoreAge] as? String
                        let ignore_avatar = restDict[FireBaseConstant.IgnoreAvatar] as? String
                        let ignore_city = restDict[FireBaseConstant.IgnoreCity] as? String
                        let ignore_date = restDict[FireBaseConstant.IgnoreDate] as? String
                        let ignore_id = restDict[FireBaseConstant.IgnoreID] as? String
                        let ignore_info = restDict[FireBaseConstant.IgnoreInfo] as? String
                        let ignore_name = restDict[FireBaseConstant.IgnoreName] as? String
                        let ignore_user_sex = restDict[FireBaseConstant.IgnoreUserSex] as? Bool
                    
                    let ignore_item = Like(like_age: ignore_age!, like_avatar: ignore_avatar!, like_city: ignore_city!, like_date: ignore_date!, like_id: ignore_id!, like_info: ignore_info!, like_name: ignore_name!, user_sex: ignore_user_sex!)
                        
                        UserVM.ignores.append(ignore_item)
                    
                    }

            }
            completion(true)
        }
    }
    func getBlocks(user_id: String, completion: @escaping (Bool) -> Void) {
        
        ref.child(FireBaseConstant.Blocks).child(user_id).observe(.value) { (snapShot) in

            let children = snapShot.children
            UserVM.blocks.removeAll()
            while let rest = children.nextObject() as? DataSnapshot {
                if let restDict = rest.value as? NSDictionary{

                        let block_age = restDict[FireBaseConstant.BlockAge] as? String
                        let block_avatar = restDict[FireBaseConstant.BlockAvatar] as? String
                        let block_city = restDict[FireBaseConstant.BlockCity] as? String
                        let block_date = restDict[FireBaseConstant.BlockDate] as? String
                        let block_id = restDict[FireBaseConstant.BlockID] as? String
                        let block_info = restDict[FireBaseConstant.BlockInfo] as? String
                        let block_name = restDict[FireBaseConstant.BlockName] as? String
                        let block_user_sex = restDict[FireBaseConstant.BlockUserSex] as? Bool
                    
                    let block_item = Like(like_age: block_age!, like_avatar: block_avatar!, like_city: block_city!, like_date: block_date!, like_id: block_id!, like_info: block_info!, like_name: block_name!, user_sex: block_user_sex!)
                        
                        UserVM.blocks.append(block_item)
                    
                    }

            }
            completion(true)
        }
    }
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
        
    }
    
    
}


