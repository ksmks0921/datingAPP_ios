//
//  SettingVM.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Foundation
import AVFoundation

class SettingVM {
    private init(){}
    static let shared = SettingVM()
    let ref : DatabaseReference = Database.database().reference()
    static var AgeList = [String]()
    static var RegionList = [String]()
    static var TallList = [String]()
    static var StyleList = [String]()
    static var JobList = [String]()
    static var StarList = [String]()
    static var OurStyleList = [String]()
    static var LifeStyleList = [String]()
    
    func getPoints() {
        UserVM.shared.getPoint(user_id: DataManager.userId!, completion: {_ in
            DataManager.points = UserVM.user_points
        })
    }
    func getRegions() {
        UserVM.shared.getLikes(user_id: DataManager.userId!, completion: {_ in
            print("Likes added successfully!")
        })
    }
    func getLikes() {
        UserVM.shared.getLikes(user_id: DataManager.userId!, completion: {_ in
            print("Likes added successfully!")
        })
    }
    func getMemos() {
        UserVM.shared.getMemos(user_id: DataManager.userId!, completion: {_ in
            print("Memos added successfully!")
        })
    }
    func getIgnores() {
        UserVM.shared.getIgnores(user_id: DataManager.userId!, completion: {_ in
            print("Ignores added successfully!")
        })
    }
    func getBlocks() {
        UserVM.shared.getBlocks(user_id: DataManager.userId!, completion: {_ in
            print("Blocks added successfully!")
        })
    }
    func getSelectingAges(completion: @escaping (Bool) -> Void){
        
       
        ref.child(FireBaseConstant.Settings).child(FireBaseConstant.AgeList).observe(.value) { (snapShot) in

               let children = snapShot.children
               SettingVM.AgeList.removeAll()
               while let rest = children.nextObject() as? DataSnapshot {
                   if let restDict = rest.value as? NSDictionary{

                            let data = restDict[FireBaseConstant.name] as? String
                            SettingVM.AgeList.append(data!)
                       }

               }
               completion(true)
        }
       
    }
    func getStars(completion: @escaping (Bool) -> Void){
           
          
           ref.child(FireBaseConstant.Settings).child(FireBaseConstant.StarList).observe(.value) { (snapShot) in

                  let children = snapShot.children
                  SettingVM.StarList.removeAll()
                  while let rest = children.nextObject() as? DataSnapshot {
                      if let restDict = rest.value as? NSDictionary{

                               let data = restDict[FireBaseConstant.name] as? String
                               SettingVM.StarList.append(data!)
                          }

                  }
                  completion(true)
           }
          
    }
    func getOurStyle(completion: @escaping (Bool) -> Void){
           
          
           ref.child(FireBaseConstant.Settings).child(FireBaseConstant.OurSideStyleList).observe(.value) { (snapShot) in

                  let children = snapShot.children
                  SettingVM.OurStyleList.removeAll()
                  while let rest = children.nextObject() as? DataSnapshot {
                      if let restDict = rest.value as? NSDictionary{

                               let data = restDict[FireBaseConstant.name] as? String
                               SettingVM.OurStyleList.append(data!)
                          }

                  }
                  completion(true)
           }
          
    }
    func getSelectingRegions(completion: @escaping (Bool) -> Void){
        
       
        ref.child(FireBaseConstant.Settings).child(FireBaseConstant.RegionList).observe(.value) { (snapShot) in

               let children = snapShot.children
               SettingVM.RegionList.removeAll()
               while let rest = children.nextObject() as? DataSnapshot {
                   if let restDict = rest.value as? NSDictionary{

                            let data = restDict[FireBaseConstant.name] as? String
                            SettingVM.RegionList.append(data!)
                       }

               }
               completion(true)
        }
       
    }
    
    func getTallSetting(completion: @escaping (Bool) -> Void) {
        ref.child(FireBaseConstant.Settings).child(FireBaseConstant.TallList).observe(.value) {(snapShot) in
            
                let children = snapShot.children
                SettingVM.TallList.removeAll()
                while let rest = children.nextObject() as? DataSnapshot {
                    if let restDict = rest.value as? NSDictionary{

                             let data = restDict[FireBaseConstant.name] as? String
                             SettingVM.TallList.append(data!)
                        }

                }
                completion(true)
            
        }
        
    }
    func getStyleSetting(completion: @escaping (Bool) -> Void) {
        ref.child(FireBaseConstant.Settings).child(FireBaseConstant.StyleList).observe(.value) {(snapShot) in
            
                let children = snapShot.children
                SettingVM.StyleList.removeAll()
                while let rest = children.nextObject() as? DataSnapshot {
                    if let restDict = rest.value as? NSDictionary{

                             let data = restDict[FireBaseConstant.name] as? String
                             SettingVM.StyleList.append(data!)
                        }

                }
                completion(true)
            
        }
        
    }
    
    func getJobSetting(completion: @escaping (Bool) -> Void) {
           ref.child(FireBaseConstant.Settings).child(FireBaseConstant.JobList).observe(.value) {(snapShot) in
               
                   let children = snapShot.children
                   SettingVM.JobList.removeAll()
                   while let rest = children.nextObject() as? DataSnapshot {
                       if let restDict = rest.value as? NSDictionary{

                                let data = restDict[FireBaseConstant.name] as? String
                                SettingVM.JobList.append(data!)
                           }

                   }
                   completion(true)
               
           }
           
    }
    func getLifeStyle(completion: @escaping (Bool) -> Void) {
           ref.child(FireBaseConstant.Settings).child(FireBaseConstant.LifeStyleList).observe(.value) {(snapShot) in
               
                   let children = snapShot.children
                   SettingVM.LifeStyleList.removeAll()
                   while let rest = children.nextObject() as? DataSnapshot {
                       if let restDict = rest.value as? NSDictionary{

                                let data = restDict[FireBaseConstant.name] as? String
                                SettingVM.LifeStyleList.append(data!)
                           }

                   }
                   completion(true)
               
           }
           
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
           DispatchQueue.global().async { //1
               let asset = AVAsset(url: url) //2
               let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
               avAssetImageGenerator.appliesPreferredTrackTransform = true //4
               let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
               do {
                   let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                   let thumbImage = UIImage(cgImage: cgThumbImage) //7
                   DispatchQueue.main.async { //8
                       completion(thumbImage) //9
                   }
               } catch {
                   print(error.localizedDescription) //10
                   DispatchQueue.main.async {
                       completion(nil) //11
                   }
               }
           }
       }
    
}
    
    

