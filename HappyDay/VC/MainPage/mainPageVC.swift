//
//  mainPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit



class mainPageVC: BaseVC {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectView: DesinableView!
    @IBOutlet weak var searchView: DesinableView!
    @IBOutlet weak var topTapCustomView: UIView!
    
    @IBOutlet weak var searchTypeView: UILabel!
    @IBOutlet weak var customPopUpView: UIView!
    @IBOutlet weak var customPopUpCellLargeView: UIView!
    
    @IBOutlet weak var TypeImageView: UIImageView!
    @IBOutlet weak var customPopUpCellGalleryView: UIView!
    
    @IBOutlet weak var customPopUpCellListView: UIView!
    @IBOutlet weak var customPopUpCellCancelView: UIView!
    
    @IBOutlet weak var backgroundForCutomPopUpView: UIView!
    var largeCollectioinViewCellId = "largeCollectionViewCell"
    var galleryCollectionViewCellId = "galleryCollectionViewCell"
    var listCollectionViewCellId = "listCollectionViewCell"

    var partners = [person]()
    var viewStyle = 0
    var search_key: String?
    @IBOutlet weak var noResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       
      
        if DataManager.isShowingSearchResult! {
            self.partners = UserVM.search_result
            if self.partners.count == 0 {
                noResultLabel.isHidden = true
            }
            if self.partners.count == 0 {
                noResultLabel.isHidden = false
            }
            else {
                noResultLabel.isHidden = true
            }
            self.collectionView.reloadData()
        }
        else {
            Indicator.sharedInstance.showIndicator()
            UserVM.shared.getUsers(completion:  {_ in
                  Indicator.sharedInstance.hideIndicator()
                  self.partners = UserVM.users
                  self.collectionView.reloadData()
            
            })
        }
        setupUI()
        
        

        
        
        
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectViewType(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        selectView.addGestureRecognizer(tapGesture)
        
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(dismissCustomPopUp(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        backgroundForCutomPopUpView.addGestureRecognizer(tapGesture_1)
        
        //custom popup menu item click functions
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(showAsListCell(_:)))
        tapGesture_2.delegate = self as? UIGestureRecognizerDelegate
        customPopUpCellListView.addGestureRecognizer(tapGesture_2)
        
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(showAsLargeCell(_:)))
        tapGesture_3.delegate = self as? UIGestureRecognizerDelegate
        customPopUpCellLargeView.addGestureRecognizer(tapGesture_3)
        
        let tapGesture_4 = UITapGestureRecognizer(target: self, action: #selector(showAsGalleryCell(_:)))
        tapGesture_4.delegate = self as? UIGestureRecognizerDelegate
        customPopUpCellGalleryView.addGestureRecognizer(tapGesture_4)
        
        let tapGesture_5 = UITapGestureRecognizer(target: self, action: #selector(cancelCustomPopup(_:)))
        tapGesture_5.delegate = self as? UIGestureRecognizerDelegate
        customPopUpCellCancelView.addGestureRecognizer(tapGesture_5)
        
        // searchType selection view click function
        let tapGestureSearch = UITapGestureRecognizer(target: self, action: #selector(gotoSearch))
        tapGestureSearch.delegate = self as? UIGestureRecognizerDelegate
        searchTypeView.isUserInteractionEnabled = true
        searchTypeView.addGestureRecognizer(tapGestureSearch)
        
        let nibCell = UINib(nibName: "largeCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: largeCollectioinViewCellId)
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
         
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
         
             let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
             navigationController?.pushViewController(VC, animated: true)
  
    }
    override func viewDidLayoutSubviews() {
        topTapCustomView.frame.size.height = navbarHeight
    }

    @objc func selectViewType(_ sender: UIView) {

        customPopUpView.isHidden = false
        backgroundForCutomPopUpView.isHidden = false
     
 
    }
    @objc func dismissCustomPopUp(_ sender: UIView) {

           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
        
    
    }
    @objc func showAsLargeCell(_ sender: UIView) {
           viewStyle = 0
           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
           let nibCell = UINib(nibName: "largeCollectionViewCell", bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: largeCollectioinViewCellId)
           collectionView.reloadData()
           TypeImageView.image = UIImage(named: "gallary_big")
        
    }
    @objc func showAsListCell(_ sender: UIView) {
           viewStyle = 2
           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
           let nibCell = UINib(nibName: "listCollectionViewCell", bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: listCollectionViewCellId)
           collectionView.reloadData()
           TypeImageView.image = UIImage(named: "gallary_list")
    
    }
    @objc func showAsGalleryCell(_ sender: UIView) {
           viewStyle = 1
           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
           let nibCell = UINib(nibName: "galleryCollectionViewCell", bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: galleryCollectionViewCellId)
           collectionView.reloadData()
           TypeImageView.image = UIImage(named: "gallary_gallary")
    
    }
    @objc func cancelCustomPopup(_ sender: UIView) {

           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
        
    
    }

    @objc func gotoSearch(_ sender: UIView) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! searchVC
        navigationController?.pushViewController(VC, animated: true)
    }
   

}
extension mainPageVC {
    func createBarBtnItem(image: UIImage, method: Selector, isLeft: Bool = false) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        button.addTarget(self, action: method, for: .touchUpInside)
        button.setImage(image, for: .normal)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        if isLeft {
            self.navigationItem.leftBarButtonItem = barButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
    }
}

extension mainPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partners.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewStyle == 0 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCollectioinViewCellId, for: indexPath) as! largeCollectionViewCell
             let partner = partners[indexPath.row]
          
             cell.region.text = partner.user_city!
             cell.age.text = partner.user_age
             cell.image.sd_setImage(with: URL(string: partner.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
             if partners[indexPath.row].user_sex == "男性" {
                cell.region.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                cell.age.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
             }
             else {
                cell.region.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                cell.age.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
             }
            
             return cell
        }
        else if viewStyle == 1 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCollectionViewCellId, for: indexPath) as! galleryCollectionViewCell
             let partner = partners[indexPath.row]
             cell.region.text = partner.user_city!
             cell.image.sd_setImage(with: URL(string: partner.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
             if partners[indexPath.row].user_sex == "男性" {
                 cell.region.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                 cell.age.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
             }
             else {
                 cell.region.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                 cell.age.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
             }
             cell.age.text = partner.user_age
             return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCollectionViewCellId, for: indexPath) as! listCollectionViewCell
            let partner = partners[indexPath.row]
            cell.name.text = partner.user_nickName!
            cell.image.sd_setImage(with: URL(string: partner.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
            
//            cell.image.image = UIImage(named: "avatar_woman")
            cell.age.text = partner.user_age!
            cell.desc.text = partner.user_introduce!
            cell.date.text = partner.user_date!
            return cell
        }
              
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewStyle == 0 {
            return CGSize(width: self.collectionView.frame.size.width/2 - 16, height: (self.collectionView.frame.size.height - 8)/3)
        }
        else if viewStyle == 1 {
            return CGSize(width: self.collectionView.frame.size.width/4 - 10, height: self.collectionView.frame.size.width/4 - 10 +  30)
        }
        else {
            return CGSize(width: self.collectionView.frame.size.width, height: 100)
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! profileVC
        VC.person = partners[indexPath.row]
        navigationController?.pushViewController(VC, animated: true)
 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if viewStyle == 0 {
            return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
        else if viewStyle == 1 {
            return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
        else {
            return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
}


