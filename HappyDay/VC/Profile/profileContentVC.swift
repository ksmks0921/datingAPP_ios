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
    let dataSource = ["profile_1", "profile_2", "profile_3"]
    var currentViewControllerIndex: Int?
    var partners = [person]()
    
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
        navigationController?.pushViewController(AdvancedExampleViewController(), animated: true)
    }
    
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        let items = ["블록 등록", "무시 등록", "메모 등록", "신고 하기"]
        popupVC.items = items
        popupVC.height = CGFloat((items.count + 1) * 60)
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        
       
      
        present(popupVC, animated: true, completion: nil)
        
    }
    @IBAction func likeBtnTapped(_ sender: Any) {
        
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.likeUser(like_age: partners[currentViewControllerIndex!].user_age!, like_avatar: partners[currentViewControllerIndex!].user_avatar![0], like_city: partners[currentViewControllerIndex!].user_city!, like_date: partners[currentViewControllerIndex!].user_date!, like_id: partners[currentViewControllerIndex!].user_id!, like_info: partners[currentViewControllerIndex!].user_introduce!, like_name: partners[currentViewControllerIndex!].user_nickName!, like_sex: partners[currentViewControllerIndex!].user_sex! ) { (success, message, error) in
                   if error == nil{
                       if success{
                            self.showAlert(message: "You liked me!")
                            Indicator.sharedInstance.hideIndicator()
                        
                        
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
