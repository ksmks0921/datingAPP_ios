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
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kUserId)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: AppConstant.kUserId)
        }
    }
    
    static var isLogin: Bool?{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kLoginStatus)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kLoginStatus)
        }
    }

    static var isShowingSearchResult: Bool?{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kShowingSearch)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kShowingSearch)
        }
    }
    static var isShowingFilterResult: Bool?{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kShowingSearch)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kShowingSearch)
        }
    }
    static var email:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kUserEmail)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: AppConstant.kUserEmail)
        }
    }
    static var password:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kUserPassword)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: AppConstant.kUserPassword)
        }
    }
    static var deviceToken:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kDeviceToken)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: AppConstant.kDeviceToken)
        }
    }
    static var points:Int! {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.points)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: AppConstant.points)
        }
    }
    static var isAutoLogin: Bool!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kIsAutoLogin)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kIsAutoLogin)
        }
    }
    static var isLockScreen: Bool!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kIsScreenLock)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kIsScreenLock)
        }
    }
    static var messageAlarm: Bool!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kMessageAlarm)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kMessageAlarm)
        }
    }
    static var likeAlarm: Bool!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kLikeAlarm)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kLikeAlarm)
        }
    }
    static var reportAlarm: Bool!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.kReportAlarm)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: AppConstant.kReportAlarm)
        }
    }
   
    static var screenLockPass: String!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.screenLockPass)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: AppConstant.screenLockPass)
        }
    }
    static var chatBackground: String!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.chatBackground)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: AppConstant.chatBackground)
        }
    }
    static var language: String!{
        set{
            UserDefaults.standard.setValue(newValue, forKey: AppConstant.Language)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: AppConstant.Language)
        }
    }
}
