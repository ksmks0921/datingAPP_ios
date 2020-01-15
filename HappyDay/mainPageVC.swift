//
//  mainPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import HSPopupMenu

class mainPageVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectView: DesinableView!
    @IBOutlet weak var searchView: DesinableView!
    
    @IBOutlet weak var searchTypeView: UILabel!
    
    
    var largeCollectioinViewCellId = "largeCollectionViewCell"
    var galleryCollectionViewCellId = "galleryCollectionViewCell"
    var listCollectionViewCellId = "listCollectionViewCell"
    
    var menuArray: [HSMenu] = []
    
    var partners = [person]()
    var viewStyle = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nibCell = UINib(nibName: "largeCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: largeCollectioinViewCellId)
      
        
        for _ in 1...10 {
            let partner = person()
            partner?.name = "zhang xiao ling"
            partners.append(partner!)
            
        }
        
        collectionView.reloadData()
        
        

        let menu1 = HSMenu(icon: UIImage(named: "sharp_apps_black_18dp")!, title: "이미지 크게")
        let menu2 = HSMenu(icon: UIImage(named: "sharp_apps_black_18dp")!, title: "갤러리 방식")
        let menu3 = HSMenu(icon: UIImage(named: "sharp_view_list_black_18dp")!, title: "리스티 방식")
        let menu4 = HSMenu(icon: UIImage(named: "sharp_cancel_black_18dp")!, title: "취소")
        menuArray = [menu1, menu2, menu3, menu4]
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectViewType(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        selectView.addGestureRecognizer(tapGesture)
        
        
        
        let tapGestureSearch = UITapGestureRecognizer(target: self, action: #selector(gotoSearch))
        tapGestureSearch.delegate = self as? UIGestureRecognizerDelegate
        searchTypeView.isUserInteractionEnabled = true
        searchTypeView.addGestureRecognizer(tapGestureSearch)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
      }

      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          navigationController?.setNavigationBarHidden(false, animated: animated)
      }
    
    @objc func selectViewType(_ sender: UIView) {
        let popupMenu = HSPopupMenu(menuArray: menuArray, arrowPoint: CGPoint(x: UIScreen.main.bounds.width-35, y: 140))
        popupMenu.popUp()
        popupMenu.delegate = self
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

                    cell.name.text = partner.name!
                    cell.image.image = UIImage(named: "first")
                 
            //               cell.layer.borderColor = UIColor.lightGray.cgColor
            //               cell.layer.borderWidth = 0.5
                    return cell
        }
        else if viewStyle == 1 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCollectionViewCellId, for: indexPath) as! galleryCollectionViewCell
             let partner = partners[indexPath.row]

                    cell.name.text = partner.name!
                    cell.image.image = UIImage(named: "first")
                 
            //               cell.layer.borderColor = UIColor.lightGray.cgColor
            //               cell.layer.borderWidth = 0.5
                    return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCollectionViewCellId, for: indexPath) as! listCollectionViewCell
             let partner = partners[indexPath.row]

                    cell.name.text = partner.name!
                    cell.image.image = UIImage(named: "first")
                 
            //               cell.layer.borderColor = UIColor.lightGray.cgColor
            //               cell.layer.borderWidth = 0.5
                    return cell
        }
              
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewStyle == 0 {
            return CGSize(width: self.collectionView.frame.size.width/2 - 10, height: self.collectionView.frame.size.width/2 - 10 +  100)
        }
        else if viewStyle == 1 {
            return CGSize(width: self.collectionView.frame.size.width/4 - 10, height: self.collectionView.frame.size.width/4 - 10 +  30)
        }
        else {
            return CGSize(width: self.collectionView.frame.size.width, height: 100)
        }
           
//        return CGSize(width: (UIScreen.main.bounds.width - 10) / 2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! profileVC
                     navigationController?.pushViewController(VC, animated: true)
        print(indexPath.item)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
}

extension mainPageVC: HSPopupMenuDelegate {
    func popupMenu(_ popupMenu: HSPopupMenu, didSelectAt index: Int) {
        viewStyle = index
        if viewStyle == 0 {
            let nibCell = UINib(nibName: "largeCollectionViewCell", bundle: nil)
            collectionView.register(nibCell, forCellWithReuseIdentifier: largeCollectioinViewCellId)
        }
        else if viewStyle == 1 {
           
            let nibCell = UINib(nibName: "galleryCollectionViewCell", bundle: nil)
            collectionView.register(nibCell, forCellWithReuseIdentifier: galleryCollectionViewCellId)
        }
        else if viewStyle == 2 {
            
            let nibCell = UINib(nibName: "listCollectionViewCell", bundle: nil)
            collectionView.register(nibCell, forCellWithReuseIdentifier: listCollectionViewCellId)
        }
        collectionView.reloadData()
        print("selected index is: " + "\(index)")
    }
}

