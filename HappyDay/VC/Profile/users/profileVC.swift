//
//  ViewController.swift
//  HappyDay
//
//  Created by Panda Star on 1/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class profileVC: BaseVC {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var name_birth: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var age_location: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var custom_title: UILabel!
    @IBOutlet weak var userinfotableview: UITableView!
    
    @IBOutlet weak var height_of_tableView: NSLayoutConstraint!
    var counter = 0
    var items = ["見ちゃイヤ", "無視する", "メモ編集", "通報する"]
    var height_row = 50
    var index: Int?
    var person : person!
    let properties_personalData: [String] = ["性別", "年齢", "居住地", "ニックネーム"]
    @IBOutlet weak var titleLabel: UILabel!
    
    var values_personalData: [String]!
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpValue()
        
        let nib = UINib.init(nibName: "profileTableViewCell", bundle: nil)
        let nib_section = UINib(nibName: "profileTableSectionCell", bundle: nil)
        let nib_rating = UINib(nibName: "selfEvaluationCell", bundle: nil)
        let nib_aboutMe = UINib(nibName: "aboutMeCell", bundle: nil)
        
        self.userinfotableview.register(nib, forCellReuseIdentifier: "profileTableViewCell")
        self.userinfotableview.register(nib_section, forCellReuseIdentifier: "profileTableSectionCell")
        self.userinfotableview.register(nib_rating, forCellReuseIdentifier: "selfEvaluationCell")
        self.userinfotableview.register(nib_aboutMe, forCellReuseIdentifier: "aboutMeCell")
        
        
        height_of_tableView.constant = CGFloat(height_row * 20)
        userinfotableview.reloadData()


//        if person != nil {
//            sections = [
//
//                Section(title: "自己紹介", items: [person.user_introduce!], values: ["what are you doing?"]),
//                Section(title: "기본정보", items: ["별명" , "성별", "년령", "거주지", "생활스타일", "혈액형", "별자리"], values: [person.user_nickName!, person.user_sex!, person.user_age!, person.user_city!, person.user_lifestyle!, person.user_blood!, person.user_star!]),
//                Section(title: "외모", items: ["신장" , "스타일", "외모", "직업"], values: [person.user_tall!, person.user_style!, person.style_1!, person.user_job!]),
//                Section(title: "자체평가", items: ["멋" ,"멋쟁이도", "부자도", "부드러움"], values: [person.style_1!, person.style_2!, person.style_3!, person.style_4!])
//
//            ]
//        }
        
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
          
          popupVC.items = items
          
          let height_view = self.view.frame.size.height
          let height_bottom_view = (items.count + 1) * 60
          if height_bottom_view > Int(height_view) {
              popupVC.height = CGFloat(height_view - 80)
          }
          else {
              popupVC.height = CGFloat(height_bottom_view)
          }
          popupVC.topCornerRadius = 10
          popupVC.presentDuration = 1
          popupVC.dismissDuration = 1
          popupVC.shouldDismissInteractivelty = true
          popupVC.delegate = self
        
          present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func sendMessageBtnTapped(_ sender: Any) {
        guard let privateChatView = storyboard?.instantiateViewController(withIdentifier: "MKPrivateChatView") as? MKPrivateChatView else { return }
        privateChatView.chatId = UserVM.current_user.user_id!
        privateChatView.connectedPerson = person
        privateChatView.chat_title = person.user_nickName
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        self.navigationController?.pushViewController(privateChatView, animated: true)
    }
    @IBAction func likeBtnTapped(_ sender: Any) {
        
        let user_sex = { () -> Bool in
            if self.person.user_sex == "男性" {
                return true
            }
            else {
                return false
            }
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date_result = formatter.string(from: date)
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.likeUser(like_age: person.user_age!, like_avatar: person.user_avatar![0], like_city: person.user_city!, like_date: date_result, like_id: person.user_id!, like_info: person.user_introduce!, like_name: person.user_nickName!, like_sex: user_sex() ) { (success, message, error) in
                   if error == nil{
                       if success{
                            self.showAlert(message: "成功!")
                            Indicator.sharedInstance.hideIndicator()
                            let sender = PushNotificationSender()
                            sender.sendPushNotification(to: "token", title: "Notification title", body: "Notification body")
                        
                        
                        } else {
                            self.showAlert(message: message)
                        }
                    
                }else {
                    self.showAlert(message: message)
                }
        }
        
    }
    
    private func setUpValue() {
        name_birth.text = person?.user_nickName
        birthday.text = person?.user_date
        age_location.text = person?.user_sex
        location.text = person?.user_city
        titleLabel.text = person?.user_nickName
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }
 
    @IBAction func preBtnTapped(_ sender: Any) {
        if counter > 0{
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            counter -= 1

        }
        else {
            counter = 3
            let index = IndexPath.init(item: counter, section: 3)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
   
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if counter < 3{
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
        if person.user_avatar != nil {
            return person.user_avatar!.count
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.sliderCollectionView.frame.size.width  , height: self.sliderCollectionView.frame.size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileImageCollectionCell", for: indexPath) as! profileImageCollectionCell
        cell.image.sd_setImage(with: URL(string: person.user_avatar![indexPath.row]), placeholderImage: UIImage(named: "avatar_woman"))
        
      
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0: return 2
            case 1: return 8
            case 2: return 5
            case 3: return 5
        default:
            return 0
        }
//        return properties_personalData.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return CGFloat(height_row)
            }
            else {
                return CGFloat(height_row)
            }
        }
        else {
            return CGFloat(height_row)
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = userinfotableview.dequeueReusableCell(withIdentifier: "profileTableSectionCell", for: indexPath as IndexPath) as! profileTableSectionCell
            cell.titleLabel.text = sections[indexPath.section].title
            cell.selectionStyle = .none
            return cell
            
        }
        else {
            let data_index = indexPath.row - 1
            if indexPath.section == 3 {
                let cell = userinfotableview.dequeueReusableCell(withIdentifier: "selfEvaluationCell", for: indexPath as IndexPath) as! selfEvaluationCell
                cell.titleLabel.text = self.sections[indexPath.section].items[data_index]
                cell.ratingView.settings.updateOnTouch = false
                let rating_value = Double(self.sections[indexPath.section].values[data_index])
                cell.ratingView.rating = rating_value!
                cell.selectionStyle = .none
                return cell
                
            }
            else if indexPath.section == 0 {
                let cell = userinfotableview.dequeueReusableCell(withIdentifier: "aboutMeCell", for: indexPath as IndexPath) as! aboutMeCell
                cell.aboutMeText.text = self.sections[indexPath.section].items[data_index]
                cell.selectionStyle = .none
                return cell
            }
            else {
                
                let cell = userinfotableview.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath as IndexPath) as! profileTableViewCell
                cell.propertyLabel?.text = self.sections[indexPath.section].items[data_index]
                cell.valueLabel?.text = self.sections[indexPath.section].values[data_index]
                cell.selectionStyle = .none
                return cell
            }
            
            
        }
            
    }
}
extension profileVC : SearchTypeDelegate{
    func selectSearchType(index: Int, type: String) {
        if type == self.items[0] {
            let avatar = person.user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            
            
            let user_sex = { () -> Bool in
                if self.person.user_sex == "男性" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.blockSomeone(block_age: person.user_age!, block_avatar: avatar![0], block_city: person.user_city!, block_date: date_result, block_id: person.user_id!, block_info: "test", block_name: person.user_nickName!, block_user_sex: user_sex()){_ in
                    self.showAlert(message: "成功!")
            }
        }
        else if type == self.items[1] {
            let avatar = person.user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            let user_sex = { () -> Bool in
                if self.person.user_sex == "男性" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.ignoreSomeone(ignore_age: person.user_age!, ignore_avatar: avatar![0], ignore_city: person.user_city!, ignore_date: date_result, ignore_id: person.user_id!, ignore_info: "test", ignore_name: person.user_nickName!, ignore_user_sex: user_sex()){_ in
                self.showAlert(message: "成功!")
            }
        }
        else if type == self.items[2] {
            let avatar = person.user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            let user_sex = { () -> Bool in
                if self.person.user_sex == "男性" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.memoSomeone(memo_age: person.user_age!, memo_avatar: avatar![0], memo_city: person.user_city!, memo_date: date_result, memo_id: person.user_id!, memo_info: "test", memo_name: person.user_nickName!, memo_user_sex: user_sex()){_ in
                    self.showAlert(message: "成功!")
            }
        }
        else if type == self.items[3] {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalDataVC") as! personalDataVC
            VC.report_person = person
            VC.from = "report"
            navigationController?.pushViewController(VC, animated: true)
        }
        else if type == self.items[4] {
            print("Cancel clicked")
        }
    }
    
    
}
