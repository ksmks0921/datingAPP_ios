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
    let ref : DatabaseReference = Database.database().reference()
    
    
    func login(email: String, password: String, response: @escaping responseCallBack){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            Indicator.sharedInstance.hideIndicator()
            if error == nil{
                DataManager.userId = user?.user.uid
                DataManager.email = user?.user.email
                self.ref.child(UserFcmIds).child(DataManager.userId!).removeValue()
                self.ref.child(UserFcmIds).child(DataManager.userId!).child(DataManager.deviceToken ?? "" ).setValue(true)
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
                let updateUser = [FireBaseConstant.kEmail: DataManager.email!,
                                  FireBaseConstant.kCity: city,
                                  FireBaseConstant.kGender: gender,
                                  FireBaseConstant.kAge: age,
                                  FireBaseConstant.kUserID : user_id
                    ] as [String : Any]
                self.ref.child(FireBaseConstant.UserNode).child(DataManager.userId!).setValue(updateUser)
                response(true, "Registered Successfully.", nil)
            }else{
                response(false, error?.localizedDescription, nil)
            }
        }
        
    }
    
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

