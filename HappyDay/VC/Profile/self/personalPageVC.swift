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
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var commentEditView: DesinableView!
    
    @IBOutlet weak var photoview: DesinableView!
    
    @IBOutlet weak var profileEditView: DesinableView!
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var avatarImageView: DesinableImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    let properties_profile: [String] = ["좋아하는", "메모 목록", "무시 목록", "블록 목록", "신고 목록", "자기 게시물보기", "알림 보기", "각종 설정", "도움말", "로그 아웃"]
    let icon_strings = ["heart.fill", "square.and.pencil", "xmark.octagon", "nosign", "star.fill", "table", "bell", "gear", "questionmark.circle.fill", "escape"]
    let icons: [UIImage] = [#imageLiteral(resourceName: "step"), #imageLiteral(resourceName: "memo-1"), #imageLiteral(resourceName: "forbidden"),#imageLiteral(resourceName: "shield"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "love")]
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var likes : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white

        
        //register collectionView
        let nibCell = UINib(nibName: "personalPageCollectionCell", bundle: nil)
        collectioView.register(nibCell, forCellWithReuseIdentifier: "personalPageCollectionCell")
        
        
        //set collectionview layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectioView!.collectionViewLayout = layout
        
        
        // set the tap function of photo select view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        uploadPhotoView.addGestureRecognizer(tapGesture)
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(profileBtnTapped(_:)))
        tapGesture_2.delegate = self as? UIGestureRecognizerDelegate
        userProfileView.addGestureRecognizer(tapGesture_2)
        
        
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(commentViewTapped(_:)))
        tapGesture_3.delegate = self as? UIGestureRecognizerDelegate
        commentView.addGestureRecognizer(tapGesture_3)
        
        
        // set init data of this page
        if DataManager.points != nil {
            pointLabel.text = String(DataManager.points) + " " + "PT"
        }
        if UserVM.current_user != nil {
            let user = UserVM.current_user
            
            avatarImageView.sd_setImage(with: URL(string: user!.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
            nameLabel.text = UserVM.current_user.user_nickName
            
        }
        
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
    @objc func commentViewTapped(_ sender: UIView) {
                let VC_2 = self.storyboard?.instantiateViewController(withIdentifier: "personalDataVC") as! personalDataVC
                navigationController?.pushViewController(VC_2, animated: true)
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
        cell.icon.image = UIImage(systemName: icon_strings[indexPath.row])

             
         cell.layer.borderColor = UIColor.lightGray.cgColor
         cell.layer.borderWidth = 0.5
         if indexPath.row != 0 && indexPath.row != 6{
            cell.badgeHeight.constant = CGFloat(0)
         }
         else {
            if indexPath.row == 0 {
                cell.otherText.text = String(UserVM.likes.count) + " 명"
            }
                cell.otherText.text = String(UserVM.likes.count) + " 개"
         }
            return cell
       
              
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: screenWidth/3, height: collectioView.frame.size.height / 4);
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.likes
            VC.titleText = "라이크 목록"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 1 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.memos
            VC.titleText = "메모 목록"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 2 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.ignores
            VC.titleText = "무시 목록"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.blocks
            VC.titleText = "블록 목록"
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
