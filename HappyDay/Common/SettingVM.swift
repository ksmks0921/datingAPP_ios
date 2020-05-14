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

class SettingVM {
    private init(){}
    static let shared = SettingVM()
    let ref : DatabaseReference = Database.database().reference()
    static var AgeList = [String]()
    static var RegionList = [String]()
    static var TallList = [String]()
    static var StyleList = [String]()
    static var JobList = [String]()
    
    
    
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
    
    
}
    
    

