//
//  createpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class createpostVC: UIViewController {

    
    @IBOutlet weak var eventTitleField: UITextField!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    
    
    @IBOutlet weak var imageShowView: UIImageView!
    @IBOutlet weak var imageSelectView: RectangularDashedView!

    @IBOutlet weak var eventRegionView: UIView!
    @IBOutlet weak var regionTextField: UILabel!
    @IBOutlet weak var eventTypeView : UIView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var phoneSettingView: UIView!
    @IBOutlet weak var phoneSettingTextField: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture_type = UITapGestureRecognizer(target: self, action: #selector(selectEventType(_:)))
        tapGesture_type.delegate = self as? UIGestureRecognizerDelegate
        eventTypeView.addGestureRecognizer(tapGesture_type)
        
        let tapGesture_city = UITapGestureRecognizer(target: self, action: #selector(selectEventCity(_:)))
        tapGesture_city.delegate = self as? UIGestureRecognizerDelegate
        eventRegionView.addGestureRecognizer(tapGesture_city)
        
        let tapGesture_phone = UITapGestureRecognizer(target: self, action: #selector(selectPhoneSetting(_:)))
        tapGesture_phone.delegate = self as? UIGestureRecognizerDelegate
        phoneSettingView.addGestureRecognizer(tapGesture_phone)
        
        let tapGesture_image = UITapGestureRecognizer(target: self, action: #selector(selectPhoneSetting(_:)))
        tapGesture_image.delegate = self as? UIGestureRecognizerDelegate
        imageSelectView.addGestureRecognizer(tapGesture_image)
    }
    @objc func selectEventType(_ sender: UIView) {
        
        guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        var items = [String]()
        for i in 1...AppConstant.eType.count - 1 {
            items.append(AppConstant.eType[i])
        }
        print(items)
        print(items.count)
        popupVC.height = CGFloat((items.count + 1 ) * 60)
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.items = items
        popupVC.delegate = self
        popupVC.index_type = 0
        self.present(popupVC, animated: true, completion: nil)
        
    }
    @objc func selectEventCity(_ sender: UIView) {
        
         SettingVM.shared.getSelectingRegions(completion: {_ in
                   guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }

                   popupVC.height = CGFloat((SettingVM.RegionList.count + 1 ) * 60)
                   popupVC.topCornerRadius = 10
                   popupVC.presentDuration = 1
                   popupVC.dismissDuration = 1
                   popupVC.shouldDismissInteractivelty = true
                   popupVC.items = SettingVM.RegionList
                   popupVC.delegate = self
                   popupVC.index_type = 1
                   self.present(popupVC, animated: true, completion: nil)
        })
        
    }
    @objc func selectPhoneSetting(_ sender: UIView) {
        
         SettingVM.shared.getSelectingRegions(completion: {_ in
                   guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
                   let items = AppConstant.phoneSetting
                   popupVC.height = CGFloat((items.count + 1 ) * 60)
                   popupVC.topCornerRadius = 10
                   popupVC.presentDuration = 1
                   popupVC.dismissDuration = 1
                   popupVC.shouldDismissInteractivelty = true
                   popupVC.items = items
                   popupVC.delegate = self
                   popupVC.index_type = 2
                   self.present(popupVC, animated: true, completion: nil)
        })
        
    }
    
    @objc func imageUpload(_ sender: UIView) {
        
        
        
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       navigationController?.setNavigationBarHidden(true, animated: animated)
      
               
    }
   

}
extension createpostVC: SearchTypeDelegate {
    
    func selectSearchType(index: Int, type: String) {
        if index == 0 {
            eventTypeLabel.text = type
            eventTypeLabel.textColor = UIColor.black
        }
        else if index == 1 {
            regionTextField.text = type
            regionTextField.textColor = UIColor.black
        }
        else  {
            phoneSettingTextField.text = type
            phoneSettingTextField.textColor = UIColor.black
        }
    }
    
    
}
