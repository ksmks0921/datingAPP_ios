//
//  personalPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class personalPageVC: UIViewController {

    @IBOutlet weak var collectioView: UICollectionView!
    @IBOutlet weak var uploadPhotoView: UIView!
    @IBOutlet weak var photoview: DesinableView!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var profileEditView: DesinableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentEditView: DesinableView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var pointerAddView: DesinableView!
    @IBOutlet weak var pointerChangeView: DesinableView!
    
    
    let properties_profile: [String] = ["발자국", "메모 목록", "무시 목록", "보면 아니야", "즐거 찾기", "친구 목록"]
    let icons: [UIImage] = [#imageLiteral(resourceName: "step"), #imageLiteral(resourceName: "memo-1"), #imageLiteral(resourceName: "forbidden"),#imageLiteral(resourceName: "shield"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "love"),]
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white

        
        //register collectionView
        let nibCell = UINib(nibName: "personalPageCollectionCell", bundle: nil)
        collectioView.register(nibCell, forCellWithReuseIdentifier: "personalPageCollectionCell")
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectioView!.collectionViewLayout = layout
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        uploadPhotoView.addGestureRecognizer(tapGesture)
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(profileBtnTapped(_:)))
        tapGesture_2.delegate = self as? UIGestureRecognizerDelegate
        userProfileView.addGestureRecognizer(tapGesture_2)
              
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(pointerAddTapped(_:)))
        tapGesture_3.delegate = self as? UIGestureRecognizerDelegate
        pointerAddView.addGestureRecognizer(tapGesture_3)
         
        let tapGesture_4 = UITapGestureRecognizer(target: self, action: #selector(pointerChangeTapped(_:)))
        tapGesture_4.delegate = self as? UIGestureRecognizerDelegate
        pointerChangeView.addGestureRecognizer(tapGesture_4)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
                
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func uploadPhotoTapped(_ sender: UIView) {
                let VC_1 = self.storyboard?.instantiateViewController(withIdentifier: "imageUploadVC") as! imageUploadVC
                navigationController?.pushViewController(VC_1, animated: true)
    }

    @objc func profileBtnTapped(_ sender: UIView) {
                let VC_2 = self.storyboard?.instantiateViewController(withIdentifier: "mainProfileVC") as! mainProfileVC
                navigationController?.pushViewController(VC_2, animated: true)
    }
    @objc func pointerAddTapped(_ sender: UIView) {
       
                let VC_3 = self.storyboard?.instantiateViewController(withIdentifier: "pointChangeVC") as! pointChangeVC
                navigationController?.pushViewController(VC_3, animated: true)
    }
    @objc func pointerChangeTapped(_ sender: UIView) {
                let VC_4 = self.storyboard?.instantiateViewController(withIdentifier: "pointChangeVC") as! pointChangeVC
                navigationController?.pushViewController(VC_4, animated: true)
    }
}
extension personalPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties_profile.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personalPageCollectionCell", for: indexPath) as! personalPageCollectionCell
             cell.txt.text = properties_profile[indexPath.row]
             cell.icon.image = icons[indexPath.row]
    
                 
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            return cell
       
              
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            return CGSize(width: screenWidth/3, height: screenWidth/3 - 20);
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "footVC") as! footVC
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 1 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "memoListVC") as! memoListVC
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 2 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ignoreListVC") as! ignoreListVC
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "noSeeVC") as! noSeeVC
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 4 {
                   let VC = self.storyboard?.instantiateViewController(withIdentifier: "favoriteListVC") as! favoriteListVC
                   navigationController?.pushViewController(VC, animated: true)
               }
        if indexPath.row == 5 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "friendListVC") as! friendListVC
            navigationController?.pushViewController(VC, animated: true)
        }
        print(indexPath.item)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
}
