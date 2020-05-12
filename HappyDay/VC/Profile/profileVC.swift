//
//  ViewController.swift
//  HappyDay
//
//  Created by Panda Star on 1/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class profileVC: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var name_birth: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var age_location: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var custom_title: UILabel!
    @IBOutlet weak var aboutMe: UILabel!
    @IBOutlet weak var userinfotableview: UITableView!
    
    var counter = 0
    
    var imgArr = [UIImage()]
    
    var index: Int?
    var person : person!
    let properties_personalData: [String] = ["성별", "년령", "거주지", "닉네임"]
    
    var values_personalData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpValue()
        
        let nib = UINib.init(nibName: "profileTableViewCell", bundle: nil)
        self.userinfotableview.register(nib, forCellReuseIdentifier: "profileTableViewCell")
        userinfotableview.reloadData()
        
        
    }
    
    private func setUpValue() {
        name_birth.text = person?.name
        birthday.text = person?.birthday
        age_location.text = person?.about_gender
        location.text = person?.live_place
        aboutMe.text = person?.aboutMe
        values_personalData = [person!.gender!, person!.age!, person!.live_place!, person!.nickName!]
        if person.photos  == 1 {
            imgArr = [UIImage(named: "katrina_1")!, UIImage(named: "katrina_2")!, UIImage(named: "katrina_3")!, ]
        }
        else if person.photos == 2 {
            imgArr = [UIImage(named: "Dilraba_1")!, UIImage(named: "Dilraba_2")!, UIImage(named: "Dilraba_3")!]
        }
        else if person.photos == 3 {
            imgArr = [UIImage(named: "tamanna_1")!, UIImage(named: "tamanna_2")!, UIImage(named: "tamanna_3")!]
        }
        else if person.photos == 4 {
            imgArr = [UIImage(named: "Bingbing_1")!, UIImage(named: "Bingbing_2")!, UIImage(named: "Bingbing_3")!]
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
 
    @IBAction func preBtnTapped(_ sender: Any) {
        if counter > 0{
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            counter -= 1

        }
        else {
            counter = imgArr.count
            let index = IndexPath.init(item: counter, section: imgArr.count)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
   
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if counter < imgArr.count{
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
           
           counter += 1

        }
        else {
           counter = 0
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
  
        }
    }

}

extension profileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.sliderCollectionView.frame.size.width  , height: self.sliderCollectionView.frame.size.height )
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileImageCollectionCell", for: indexPath) as! profileImageCollectionCell

       cell.image.image = imgArr[indexPath.row]
       return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
                return 3.0
      
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
           UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
           return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension profileVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return properties_personalData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = userinfotableview.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath as IndexPath) as! profileTableViewCell
            
            cell.propertyLabel?.text = self.properties_personalData[indexPath.row]
            cell.valueLabel?.text = self.values_personalData[indexPath.row]
            return cell
    }
}
