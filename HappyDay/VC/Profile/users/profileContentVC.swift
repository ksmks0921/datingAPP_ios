//
//  profileCotentVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/25/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class profileContentVC: BaseVC {

    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    var currentViewControllerIndex: Int?
    var partners = [person]()
    var items = ["블록 등록", "무시 등록", "메모 등록", "신고 하기"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTitle.text = partners[currentViewControllerIndex!].user_nickName
        configurePageViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
  
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessageBtnTapped(_ sender: Any) {


//        let privateChatView = MKPrivateChatView(chatId: UserVM.current_user.user_id!, connectedPerson: partners[currentViewControllerIndex!])
         guard let privateChatView = storyboard?.instantiateViewController(withIdentifier: "MKPrivateChatView") as? MKPrivateChatView else { return }
        privateChatView.chatId = UserVM.current_user.user_id!
        privateChatView.connectedPerson = partners[currentViewControllerIndex!]
        privateChatView.chat_title = partners[currentViewControllerIndex!].user_nickName
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로"
        backItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        self.navigationController?.pushViewController(privateChatView, animated: true)
        
    }
    
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        
        popupVC.items = items
        popupVC.height = CGFloat((items.count + 1) * 60)
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true      
        popupVC.delegate = self
      
        present(popupVC, animated: true, completion: nil)
        
    }
    @IBAction func likeBtnTapped(_ sender: Any) {
        let user_sex = { () -> Bool in
            if self.partners[self.currentViewControllerIndex!].user_sex == "남자" {
                return true
            }
            else {
                return false
            }
        }
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.likeUser(like_age: partners[currentViewControllerIndex!].user_age!, like_avatar: partners[currentViewControllerIndex!].user_avatar![0], like_city: partners[currentViewControllerIndex!].user_city!, like_date: partners[currentViewControllerIndex!].user_date!, like_id: partners[currentViewControllerIndex!].user_id!, like_info: partners[currentViewControllerIndex!].user_introduce!, like_name: partners[currentViewControllerIndex!].user_nickName!, like_sex: user_sex() ) { (success, message, error) in
                   if error == nil{
                       if success{
                            self.showAlert(message: "성공!")
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
    
    private func configurePageViewController(){
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: profilePageViewController.self)) as? profilePageViewController else {
            return
        }
        pageViewController.delegate = self as! UIPageViewControllerDelegate
        pageViewController.dataSource = self as! UIPageViewControllerDataSource
        
        addChild(pageViewController)
        
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex!) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    func detailViewControllerAt(index: Int) -> profileVC? {
        
        if index >= partners.count || partners.count == 0 {
            return nil
        }
        guard let profileVC = storyboard?.instantiateViewController(withIdentifier: String(describing: profileVC.self)) as? profileVC else {
            
            return nil
        }
        
        profileVC.index = index
        profileVC.person = self.partners[index]
        return profileVC

    }
    

}


extension profileContentVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex!
    }
    
    func presentationCount (for pageViewController: UIPageViewController) -> Int {
        return partners.count
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let profileVC = viewController as? profileVC
        guard var currentIndex = profileVC?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let profileVC = viewController as? profileVC
        guard var currentIndex = profileVC?.index else {
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
        
    }
    
}
extension profileContentVC : SearchTypeDelegate{
    func selectSearchType(index: Int, type: String) {
        if type == self.items[0] {
            let avatar = partners[currentViewControllerIndex!].user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            let user_sex = { () -> Bool in
                if self.partners[self.currentViewControllerIndex!].user_sex == "남자" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.blockSomeone(block_age: partners[currentViewControllerIndex!].user_age!, block_avatar: avatar![0], block_city: partners[currentViewControllerIndex!].user_city!, block_date: date_result, block_id: partners[currentViewControllerIndex!].user_id!, block_info: "test", block_name: partners[currentViewControllerIndex!].user_nickName!, block_user_sex: user_sex()){_ in
                    self.showAlert(message: "성공!")
            }
        }
        else if type == self.items[1] {
            let avatar = partners[currentViewControllerIndex!].user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            let user_sex = { () -> Bool in
                if self.partners[self.currentViewControllerIndex!].user_sex == "남자" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.ignoreSomeone(ignore_age: partners[currentViewControllerIndex!].user_age!, ignore_avatar: avatar![0], ignore_city: partners[currentViewControllerIndex!].user_city!, ignore_date: date_result, ignore_id: partners[currentViewControllerIndex!].user_id!, ignore_info: "test", ignore_name: partners[currentViewControllerIndex!].user_nickName!, ignore_user_sex: user_sex()){_ in
                self.showAlert(message: "성공!")
            }
        }
        else if type == self.items[2] {
            let avatar = partners[currentViewControllerIndex!].user_avatar
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date_result = formatter.string(from: date)
            let user_sex = { () -> Bool in
                if self.partners[self.currentViewControllerIndex!].user_sex == "남자" {
                    return true
                }
                else {
                    return false
                }
            }
            UserVM.shared.memoSomeone(memo_age: partners[currentViewControllerIndex!].user_age!, memo_avatar: avatar![0], memo_city: partners[currentViewControllerIndex!].user_city!, memo_date: date_result, memo_id: partners[currentViewControllerIndex!].user_id!, memo_info: "test", memo_name: partners[currentViewControllerIndex!].user_nickName!, memo_user_sex: user_sex()){_ in
                    self.showAlert(message: "성공!")
            }
        }
        else if type == self.items[3] {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "personalDataVC") as! personalDataVC
            VC.report_person = partners[currentViewControllerIndex!]
            VC.from = "report"
            navigationController?.pushViewController(VC, animated: true)
        }
        else if type == self.items[4] {
            print("Cancel clicked")
        }
    }
    
    
}
