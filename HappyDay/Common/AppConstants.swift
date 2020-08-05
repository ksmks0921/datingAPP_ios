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
    static let kUserPassword = "kUserPassword"
    static let kDeviceToken = "deviceToken"
    static let UserFcmIds = "user-fcm-ids"
    static let LanguageEnglish = "english"
    static let LanguageJapanese = "japanese"
    static let LanguageKorean = "korean"
    static let LanguageChinese = "chinese"
    static let languages = ["English", "日本語","한국어", "中文"]
    static let kShowingSearch = "kSearch"
    static let kIsAutoLogin = "kIsAutoLogin"
    static let kIsScreenLock = "kIsScreenLock"
    static let kMessageAlarm = "kMessageAlarm"
    static let kReportAlarm = "kReportAlarm"
    static let kLikeAlarm = "kLikeAlarm"
    static let kShowingFilter = "kFilter"
    static let Language = "Language"
    static let screenLockPass = "screenLockPass"
    
    static let API_KEY_TRANSLATE = "AIzaSyBNoD64Un372JgIMHQMQ0ODF9eBsq59GIM"
    
    static let eVideo = "video"
    static let eImage = "image"
    static let eText = "text"
    static let eEmoji  = "emoji"
    static let points = "points"
    static let eAll = "全体"
    static let eType = ["全体", "メール友募集", "今からあそぼ", "友達募集", "ミドルエイジ", "すぐ会いたい", "すぐ会いたい"]
    static let event_Type = ["メール友募集", "今からあそぼ", "友達募集", "ミドルエイジ", "すぐ会いたい", "すぐ会いたい"]
    static let phoneSetting = ["1時間後まで受ける", "2時間後まで受ける", "3時間後まで受ける", "4時間後まで受ける", "5時間後まで受ける"]
    static let height_60 = 60
    static let height_50 = 50
    static let height_40 = 40
    static let height_postTableCell = 340
    static let defatul_image_url = "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/images%2Ficon_userphoto2.png?alt=media&token=275a03b5-24b3-4931-aa4a-d71e71f0d9df"
    
    static let stickers = ["https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa1.gif?alt=media&token=3ce4678d-0213-4250-b868-1bc9fa3b71d5",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa10.gif?alt=media&token=06c55dc1-3577-40d2-8b2b-e3dc95b78d6f",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa11.gif?alt=media&token=64645389-8712-4cbc-bf2a-40d7e4f7dd37",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa12.gif?alt=media&token=f6fd8550-94e6-4692-92db-b49a17d3fd6b",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa13.gif?alt=media&token=acad28f3-dbf6-4b66-a21f-6989a789e7df",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa14.gif?alt=media&token=47fe1d6c-e284-44a1-8f29-b038fc1aa871",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa15.gif?alt=media&token=8e83a583-0157-4856-b2ff-81303918a607",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa16.gif?alt=media&token=b3a60e9f-3f5b-44ec-b99b-5af17647483d",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa2.gif?alt=media&token=227f161b-ebb1-474a-b0d8-4a3b5ff9f847",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa3.gif?alt=media&token=5ee05db9-742c-4eea-bde9-7a13c8775e1b",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa4.gif?alt=media&token=0a59c64f-f232-453f-8bc2-fb10891037d6",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa5.gif?alt=media&token=c5dcda6d-eb2f-490e-8223-b53a13c05813",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa6.gif?alt=media&token=454792a1-41bc-433a-9919-d518a06e63d4",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa7.gif?alt=media&token=10dcb677-2faf-455f-9eed-6da84a9b11f9",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa8.gif?alt=media&token=bf28893e-cb91-482c-b89d-a5dccd7b59ae",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fa9.gif?alt=media&token=174a3b77-98bc-47c2-ac4e-0b0ce9faa323",

    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb1.png?alt=media&token=8f5b16b6-afeb-4d99-b801-083d8b086a1c",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb10.png?alt=media&token=6ee1614e-84bf-4487-a1cb-616cc4c6e90d",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb11.png?alt=media&token=e0b53720-8300-44ed-ae56-ca20ab0c656d",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb12.png?alt=media&token=eeb04adc-269b-498b-9050-8fa80e44ab96",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb13.png?alt=media&token=d6616fdf-61b7-46a2-b0f5-7dc07794dc29",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb14.png?alt=media&token=ce7a4f5c-13a6-4216-a8b8-71e52823ed35",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb15.png?alt=media&token=2106f8bf-5784-46c9-9af3-3694347e856e",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb16.png?alt=media&token=ab4ffdf6-0392-4fea-8cf7-b20504679f9b",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb2.png?alt=media&token=82c431cd-a853-40b5-a762-fbffe82398c8",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb3.png?alt=media&token=1dfb6d70-f342-47a9-acf7-d3d388a0cf0f",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb4.png?alt=media&token=a9aa75d2-aaee-46a3-b05f-77ca0ac933e1",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb5.png?alt=media&token=2f3e52c4-d1f4-4420-8f57-c2a688bceb34",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb6.png?alt=media&token=eb7ae00e-1e29-494b-942e-ba45057074c4",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb7.png?alt=media&token=4bc27e13-287a-4d84-9266-985aac272a85",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb8.png?alt=media&token=77a30c7d-e3da-4e42-973b-4e3b1a2d4c43",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fb9.png?alt=media&token=1a8d135d-6f3c-4f81-9043-6fe3dbfeb022",

    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd9.gif?alt=media&token=23fd9859-ec9d-40b5-bc46-d6522b55b1d4",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd8.gif?alt=media&token=eae4d405-7923-4abc-a710-41e00103d9e2",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd7.gif?alt=media&token=d7ece2b7-e688-49cc-b216-799f5d245669",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd6.gif?alt=media&token=4af4421f-ce54-4e49-aad7-3dbbeb013c95",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd5.gif?alt=media&token=2364fbb1-8f87-4d92-a241-d526be32086f",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd4.gif?alt=media&token=dacab78b-f768-4972-8c42-a12d6973175d",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd3.gif?alt=media&token=951b77dc-710f-4b66-90ac-fe14ed70b6af",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd2.gif?alt=media&token=e1edb2da-4082-446d-aaf2-ffdb11d4d8e3",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd16.gif?alt=media&token=279e3339-d1bd-49c8-b6bc-8ca6b230be84",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd15.gif?alt=media&token=33b5b811-1363-4c56-abe5-7321692ddab4",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd14.gif?alt=media&token=52084fbe-af41-4002-a32c-577d47d9cb0a",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd13.gif?alt=media&token=43dc1e92-8be2-44b7-bce3-6699f3d977d3",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd12.gif?alt=media&token=9285ead9-fc59-4594-92a6-d898c96e788c",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd11.gif?alt=media&token=b4dbd6f6-afb8-441d-a2c7-d2dbe8d5978c",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd10.gif?alt=media&token=017160b3-c7cd-4d91-a73e-79c3a5bbe07f",
    "https://firebasestorage.googleapis.com/v0/b/happyday-c2593.appspot.com/o/Emogies%2Fd1.gif?alt=media&token=e489c1f4-3a21-4685-9d0b-72e29711b4ec"
]
    
    
    
}
