//
//  mainPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class mainPageVC: UIViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nibCell = UINib(nibName: "largeCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: largeCollectioinViewCellId)
      
        if search_key != nil {
              
            
            
            
            
//            let person_1 = person(id : 1, name: "카트리나", avatar: "katrina_1", photos: 1, birthday: "16/05/1983", about_gender: "30대 후반", live_place: "홍콩", aboutMe: "힌디어 영화에서 일하는 영국 여배우. 그녀의 연기력에 대한 비평가들로부터 혼합 된 리뷰를 받았음에도 불구하고, 그녀는 볼리우드에서 자신을 설립했으며 인도에서 가장 보수가 많은 여배우 중 한 명입니다.", gender: "녀성", age: "35세~40세", nickName: "얼음공주", job: "배우")
//            partners.append(person_1)
//            let person_2 = person(id : 2, name: "딜라바", avatar: "Dilraba_1", photos: 2, birthday: "03/06/1992", about_gender: "20대 후반", live_place: "딜리레바", aboutMe: "중국 배우, 모델 및 가수입니다. 그녀는 위구르족 출신이다.", gender: "녀성", age: "20세~25세", nickName: "기녀", job: "모델 및 가수")
//            partners.append(person_2)
//            let person_3 = person(id : 3, name: "타만나", avatar: "tamanna_1", photos: 3, birthday: "21/12/1989", about_gender: "30대 전반", live_place: "뭄바이", aboutMe: "전문적으로 타마 나아 (Tamannaah)라고 알려진 인도의 여배우는 주로 타밀어와 텔루구어 영화에 출연한다. 그녀는 여러 힌디어 영화에도 출연했다. 연기 외에도 그녀는 무대 쇼에 참여하며 브랜드 및 제품의 저명한 유명인입니다.", gender: "녀성", age: "30세~35세", nickName: "따영", job: "배우")
//            partners.append(person_3)
//            let person_4 = person(id : 4, name: "빙빙", avatar: "Bingbing_1", photos: 4, birthday: "16/09/1981", about_gender: "30대 후반", live_place: "청도", aboutMe: " 중국 배우, 모델, TV 프로듀서 및 가수입니다. 2013 년부터 Fan은 2006 년 이후 매년 상위 10 위에 오른 이후 포브 차이나 셀러브리티 100 (Forbes China Celebrity 100)에서 4 년 연속 가장 높은 유명인으로 선정되었습니다.그녀는 세계에서 가장 보수가 많은 여배우 중 한 명이며 레드 카펫, 영화 시사회 및 패션쇼에서 자주 출연하기 때문에 글로벌 패션 아이콘이라고 불렀습니다.", gender: "녀성", age: "35세~40세", nickName: "배뚱이", job: "배우")
//            partners.append(person_4)
            
        }
        else {
//             let person_1 = person(id : 1, name: "카트리나", avatar: "katrina_1", photos: 1, birthday: "16/05/1983", about_gender: "30대 후반", live_place: "홍콩", aboutMe: "힌디어 영화에서 일하는 영국 여배우. 그녀의 연기력에 대한 비평가들로부터 혼합 된 리뷰를 받았음에도 불구하고, 그녀는 볼리우드에서 자신을 설립했으며 인도에서 가장 보수가 많은 여배우 중 한 명입니다.", gender: "녀성", age: "35세~40세", nickName: "얼음공주", job: "배우")
//             partners.append(person_1)
//             let person_2 = person(id : 2, name: "딜라바", avatar: "Dilraba_1", photos: 2, birthday: "03/06/1992", about_gender: "20대 후반", live_place: "딜리레바", aboutMe: "중국 배우, 모델 및 가수입니다. 그녀는 위구르족 출신이다.", gender: "녀성", age: "20세~25세", nickName: "기녀", job: "모델 및 가수")
//             partners.append(person_2)
//             let person_3 = person(id : 3, name: "타만나", avatar: "tamanna_1", photos: 3, birthday: "21/12/1989", about_gender: "30대 전반", live_place: "뭄바이", aboutMe: "전문적으로 타마 나아 (Tamannaah)라고 알려진 인도의 여배우는 주로 타밀어와 텔루구어 영화에 출연한다. 그녀는 여러 힌디어 영화에도 출연했다. 연기 외에도 그녀는 무대 쇼에 참여하며 브랜드 및 제품의 저명한 유명인입니다.", gender: "녀성", age: "30세~35세", nickName: "따영", job: "배우")
//             partners.append(person_3)
//             let person_4 = person(id : 4, name: "빙빙", avatar: "Bingbing_1", photos: 4, birthday: "16/09/1981", about_gender: "30대 후반", live_place: "청도", aboutMe: " 중국 배우, 모델, TV 프로듀서 및 가수입니다. 2013 년부터 Fan은 2006 년 이후 매년 상위 10 위에 오른 이후 포브 차이나 셀러브리티 100 (Forbes China Celebrity 100)에서 4 년 연속 가장 높은 유명인으로 선정되었습니다.그녀는 세계에서 가장 보수가 많은 여배우 중 한 명이며 레드 카펫, 영화 시사회 및 패션쇼에서 자주 출연하기 때문에 글로벌 패션 아이콘이라고 불렀습니다.", gender: "녀성", age: "35세~40세", nickName: "배뚱이", job: "배우")
//             partners.append(person_4)
        }
        
        collectionView.reloadData()


        
        
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
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
           TypeImageView.image = UIImage(systemName: "square.grid.2x2.fill")
        
    }
    @objc func showAsListCell(_ sender: UIView) {
           viewStyle = 2
           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
           let nibCell = UINib(nibName: "listCollectionViewCell", bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: listCollectionViewCellId)
           collectionView.reloadData()
           TypeImageView.image = UIImage(systemName: "rectangle.grid.1x2.fill")
    
    }
    @objc func showAsGalleryCell(_ sender: UIView) {
           viewStyle = 1
           customPopUpView.isHidden = true
           backgroundForCutomPopUpView.isHidden = true
           let nibCell = UINib(nibName: "galleryCollectionViewCell", bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: galleryCollectionViewCellId)
           collectionView.reloadData()
           TypeImageView.image = UIImage(systemName: "square.grid.3x2.fill")
    
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
          
             cell.name.text = partner.name!
             cell.age.text = partner.about_gender
             cell.image.image = UIImage(named: partner.avatar ?? "avatar_woman")
             cell.otherDescription.isHidden = true
             return cell
        }
        else if viewStyle == 1 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCollectionViewCellId, for: indexPath) as! galleryCollectionViewCell
             let partner = partners[indexPath.row]
             cell.name.text = partner.name!
             cell.image.image = UIImage(named: partner.avatar ?? "avatar_woman")
             cell.age.text = partner.age!
             return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCollectionViewCellId, for: indexPath) as! listCollectionViewCell
            let partner = partners[indexPath.row]
            cell.name.text = partner.name!
            cell.image.image = UIImage(named: partner.avatar ?? "avatar_woman")
            cell.age.text = partner.age!
            cell.desc.text = partner.aboutMe!
            cell.date.text = partner.birthday!
            return cell
        }
              
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewStyle == 0 {
            return CGSize(width: self.collectionView.frame.size.width/2 - 16, height: self.collectionView.frame.size.width/2 - 16 +  60)
        }
        else if viewStyle == 1 {
            return CGSize(width: self.collectionView.frame.size.width/4 - 10, height: self.collectionView.frame.size.width/4 - 10 +  30)
        }
        else {
            return CGSize(width: self.collectionView.frame.size.width, height: 100)
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileContentVC") as! profileContentVC
        VC.currentViewControllerIndex = indexPath.row
        VC.partners = partners
        navigationController?.pushViewController(VC, animated: true)

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if viewStyle == 0 {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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


