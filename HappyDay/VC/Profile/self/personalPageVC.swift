//
//  personalPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import QuickLook

class personalPageVC: BaseVC {

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
    
    let properties_profile: [String] = ["お気に入り", "メモリスト", "無視リスト", "見ちゃイヤ", "通報リスト", "掲示板履歴", "お知らせ", "各種設定", "お問い合わせ", "ログアウト"]
    let icon_strings = ["icon_heart", "icon_memo", "icon_block", "icon_misi", "icon_favourite", "feedon", "notification", "gear", "icon_helper", "icon_logout"]
   
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var likes : Int!
    var previewItem = NSURL()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = default_green_color
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
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
        if DataManager.isLockScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        if UserVM.current_user != nil {
            let user = UserVM.current_user
            avatarImageView.sd_setImage(with: URL(string: user!.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

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
    func showHelpDoc() {
 
        let previewController = QLPreviewController()
        self.previewItem = getPreviewItem(withName : "help.docx")
        previewController.dataSource = self
//
//        UINavigationBar.appearance(whenContainedInInstancesOf: [QLPreviewController.self]).backgroundColor = UIColor.green
//     
        self.present(previewController, animated: true, completion: nil)
        
    }
    func getPreviewItem(withName name: String) -> NSURL{
        let file = name.components(separatedBy: ".")
        let path = Bundle.main.path(forResource: file.first!, ofType: file.last!)
        let url = NSURL(fileURLWithPath: path!)
        return url
    }
    
}
extension personalPageVC : QLPreviewControllerDataSource, QLPreviewControllerDelegate  {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
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
        cell.icon.image = UIImage(named: icon_strings[indexPath.row])

             
         cell.layer.borderColor = UIColor.lightGray.cgColor
         cell.layer.borderWidth = 0.5
         if indexPath.row != 0 && indexPath.row != 6{
            cell.badgeView.isHidden = true
         }
         else {
            cell.badgeView.isHidden = false
            if indexPath.row == 0 {
                cell.otherText.text = String(UserVM.likes.count) + "人"
            }
                cell.otherText.text = String(UserVM.likes.count) + "個"
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
            VC.titleText = "お気に入り"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 1 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.memos
            VC.titleText = "メモリスト"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 2 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.ignores
            VC.titleText = "無視リスト"
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalPageItemVC") as! personalPageItemVC
            VC.items = UserVM.blocks
            VC.titleText = properties_profile[indexPath.row]
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 4 {
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "reportListVC") as! reportListVC
           navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 5 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "userPostsVC") as! userPostsVC
            VC.titleText = properties_profile[indexPath.row]
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 6 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "alertViewVC") as! alertViewVC
          
            navigationController?.pushViewController(VC, animated: true)
            
        }
        if indexPath.row == 7 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "settingVC") as! settingVC
          
            navigationController?.pushViewController(VC, animated: true)
            
        }
        if indexPath.row == 8 {
            self.showHelpDoc()
        }
        if indexPath.row == 9 {
                    Indicator.sharedInstance.showIndicator()
                       UserVM.shared.logout() { (success, message, error) in
                                  if error == nil{
                                      if success{
                                           Indicator.sharedInstance.hideIndicator()
                                           DataManager.isLogin = false
                                           
                                           let VC = self.storyboard?.instantiateViewController(withIdentifier: "FirstPageVC") as! FirstPageVC
                                           self.navigationController?.pushViewController(VC, animated: true)
                                           
                                       
                                       
                                       } else {
                                           print("______")
                                       }
                                   
                               }else {
                                   print("______")
                               }
                       }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
}
