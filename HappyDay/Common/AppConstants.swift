//
//  AppConstants.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation



enum SearchType : String{
    case PROFILE
    case NICKNAME
}


class AppConstant {
    
    static let kUserId = "userId"
    static let kLoginStatus = "loginStatus"
    static let kUserEmail = "userEmail"
    static let kDeviceToken = "deviceToken"
    static let UserFcmIds = "user-fcm-ids"
    static let kShowingSearch = "kSearch"
    static let kShowingFilter = "kFilter"
    static let eVideo = "video"
    static let eImage = "image"
    static let points = "points"
    static let eAll = "전체"
    static let eType = ["전체", "메일친구 모집", "지금부터 즐기는", "친구 모집", "성인, 나이많은", "애호가", "연인모집"]
    static let phoneSetting = ["1시간 후까지 받음", "2시간 후까지 받음", "3시간 후까지 받음", "4시간 후까지 받음", "5시간 후까지 받음"]
    static let height_60 = 60
    static let height_postTableCell = 300
}
