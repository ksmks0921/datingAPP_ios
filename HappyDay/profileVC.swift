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
    @IBOutlet weak var age_location: UILabel!
    @IBOutlet weak var custom_title: UILabel!
    @IBOutlet weak var userinfotableview: UITableView!
    
    var counter = 0
    
    var imgArr = [ UIImage(named: "profile_1"),
                   UIImage(named: "profile_2"),
                   UIImage(named: "profile_3")]
    
    
    let properties_nickname: [String] = ["성별", "년령", "거주지", "닉네임"]
    let values_nickname: [String] = ["녀성", "19세 ~ 21세", "장춘", "따영"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        let nib = UINib.init(nibName: "profileTableViewCell", bundle: nil)
        self.userinfotableview.register(nib, forCellReuseIdentifier: "profileTableViewCell")
        userinfotableview.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
           UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
       
        return properties_nickname.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = userinfotableview.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath as IndexPath) as! profileTableViewCell
            cell.propertyLabel?.text = self.properties_nickname[indexPath.row]
            cell.valueLabel?.text = self.values_nickname[indexPath.row]
            return cell
    }
}
