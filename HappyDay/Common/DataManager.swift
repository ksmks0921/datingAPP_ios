//
//  DataManager.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
class DataManager {
    
    static var userId:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: kUserId)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: kUserId)
        }
    }
    
    static var isLogin: Bool?{
        set{
            UserDefaults.standard.setValue(newValue, forKey: kLoginStatus)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: kLoginStatus)
        }
    }
    
    static var email:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: kUserEmail)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: kUserEmail)
        }
    }
    
    static var deviceToken:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: kDeviceToken)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: kDeviceToken)
        }
    }
}
