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
    
    func login(email: String, password: String, response: @escaping responseCallBack){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            Indicator.sharedInstance.hideIndicator()
            if error == nil{
                DataManager.userId = user?.user.uid
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
                            let user_avatar = restDict[FireBaseConstant.kUserAvatar] as? String
                            let user_blood = restDict[FireBaseConstant.kUserBlood] as? String
                            let user_city = restDict[FireBaseConstant.kCity] as? String
                            let user_date = restDict[FireBaseConstant.kUserDate] as? String
                            let user_email = restDict[FireBaseConstant.kAge] as? String
                            let user_id = restDict[FireBaseConstant.kUserID] as? String
                            let user_introduce = restDict[FireBaseConstant.kUserIntroduce] as? String
                            let user_job = restDict[FireBaseConstant.kUserJob] as? String
                            let user_lifestyle = restDict[FireBaseConstant.kUserLifeStyle] as? String
                            let user_nickName = restDict[FireBaseConstant.kUserNickName] as? String
                            let user_outside = restDict[FireBaseConstant.kUserOutside] as? String
                            let user_sex = restDict[FireBaseConstant.kUserSex] as? String
                            let user_star = restDict[FireBaseConstant.kUserStar] as? String
                            let user_style = restDict[FireBaseConstant.kUserStyle] as? String
                            let user_tall = restDict[FireBaseConstant.kUserTall] as? String
                            let user_createdAt = restDict[FireBaseConstant.kCreatedAt] as? String
                            let user_status = restDict[FireBaseConstant.kStatus] as? String
                    
                            
                           
                            
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

