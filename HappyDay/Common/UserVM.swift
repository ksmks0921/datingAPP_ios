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
    let ref : DatabaseReference = Database.database().reference()
    
    
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
                
                response(true, "Login Successfully.", nil)
            }else{
                response(false, error?.localizedDescription, nil)
            }
        }
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
                                  FireBaseConstant.kUserAvatar    : "",
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
                                  FireBaseConstant.kCreatedAt     : "",
                                  FireBaseConstant.kUpdatedAt     : "",
                                  FireBaseConstant.kIsApproved    : "",
                                  FireBaseConstant.kRequireAge    : "",
                                  FireBaseConstant.kRequireStyle  : "",
                                  FireBaseConstant.kRequireTall   : ""
                    ]
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
                            let user_id = restDict[FireBaseConstant.kUserID] as? String
                            let user_introduce = restDict[FireBaseConstant.kUserIntroduce] as? String
                            let user_job = restDict[FireBaseConstant.kUserJob] as? String
                            let user_lifestyle = restDict[FireBaseConstant.kUserLifeStyle] as? String
                            let user_nickName = restDict[FireBaseConstant.kUserNickName] as? String
                            let user_outside = restDict[FireBaseConstant.kUserOutside] as? String
                    
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
                            let person_item = person(required_age: required_age!, require_style: require_style!, require_tall: require_tall!, style_1: style_1!, style_2: style_2!, style_3: style_3!,  style_4: style_4!, user_age: user_age!, user_avatar: user_avatar_list, user_blood: user_blood!, user_city: user_city!, user_date: user_date!, user_email: user_email!, user_id: user_id!, user_introduce : user_introduce!,user_job: user_job!, user_lifestyle: user_lifestyle!, user_nickName: user_nickName!, user_outside: user_outside!, user_sex: user_sex!, user_star: user_star!, user_style: user_style!, user_tall: user_tall!,  user_status : user_status!)
                            
                            UserVM.users.append(person_item)
                    

                   }
                  
            }
            
             completion(true)
        }
    
        
        
        
    }
    
    
    func search(sex : String, city: String, age: String, tall: String, style: String, job: String, nick_name: String, completion: @escaping (Bool) -> Void) {
       
        UserVM.search_result = UserVM.users
        
        if sex != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "sex", value: sex)
        }
        if city != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "city", value: city)
        }
        if age != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "age", value: age)
        }
        if tall != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "tall", value: tall)
        }
        if style != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "style", value: style)
        }
        if job != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "job", value: job)
        }
        if nick_name != "전체" {
            UserVM.search_result = filter(init_data: UserVM.search_result, key: "nick_name", value: nick_name)
        }
       
        completion(true)
        
    }
    
    func filter(init_data: [person], key: String, value: String) -> [person] {
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
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
}

class SearchKey {
    var key: String!
    var value: String!
    
    init(key: String, value: String)  {
        self.key = key
        self.value = value
    }
    
}
