//
//  createpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import PopupDialog
import FirebaseStorage

class createpostVC: BaseVC {

    
    @IBOutlet weak var eventTitleField: UITextField!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    
    
    @IBOutlet weak var imageShowView: UIImageView!
    @IBOutlet weak var imageSelectView: RectangularDashedView!
    @IBOutlet weak var imageSelect: UIView!
    
    @IBOutlet weak var eventRegionView: UIView!
    @IBOutlet weak var regionTextField: UILabel!
    @IBOutlet weak var eventTypeView : UIView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var phoneSettingView: UIView!
    @IBOutlet weak var phoneSettingTextField: UILabel!
    var media : String!
    var video_url: URL!
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
        
        let tapGesture_image = UITapGestureRecognizer(target: self, action: #selector(imageUpload(_:)))
        tapGesture_image.delegate = self as? UIGestureRecognizerDelegate
        imageSelect.addGestureRecognizer(tapGesture_image)
 
    }
    @objc func selectEventType(_ sender: UIView) {
        
        guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        var items = [String]()
        for i in 1...AppConstant.eType.count - 1 {
            items.append(AppConstant.eType[i])
        }
       
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
    
    @objc func imageUpload(_ sender: UIImageView) {
        
        showImagePickerControllerActionSheet()
        
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        Indicator.sharedInstance.showIndicator()
               let storageRef = Storage.storage().reference().child("media").child(UUID().uuidString)
                    if let uploadData = imageShowView.image!.pngData() {
                   
                   storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                       Indicator.sharedInstance.hideIndicator()
                       if error != nil {
                           print("error")
                           
                       } else {
                           storageRef.downloadURL { (url, error) in
                               guard let downloadURL = url else {return}
                            self.registerEvent(url: downloadURL)
                               
                   
                           }
        
                       }
                   }
        }
        
        
    }
    
    func registerEvent(url: URL) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date_result = formatter.string(from: date)
        if eventTitleField.text == "" {
            self.showAlert(message: "제목란을 채우세요.")
            return
        }
        if regionTextField.text == "" {
            self.showAlert(message: "지역을 선택해주세요.")
            return
        }
        if phoneSettingTextField.text == "" {
            self.showAlert(message: "전화접수 설정을 선택해주세요.")
            return
        }
        if eventTypeLabel.text == "" {
            self.showAlert(message: "이벤트형을 선택해주세요.")
            return
        }
        if eventTextField.text == "" {
            self.showAlert(message: "이벤트 본문을 입력해주세요.")
            
            return
        }
        let user_age = UserVM.current_user.user_age
        let user_avatar =  UserVM.current_user.user_avatar
        let user_gender: Bool!
        if UserVM.current_user.user_sex == "녀자" {
           user_gender = false
        }
        else {
           user_gender = true
        }
        
        let user_job = UserVM.current_user.user_job
        let user_name = UserVM.current_user.user_nickName
        let user_style = UserVM.current_user.user_style
        let user_tall = UserVM.current_user.user_tall
        let user_id = UserVM.current_user.user_id
        let row_key = ""
        let source_type = self.media
        let thumb_path : String!
        if media == "image" {
             thumb_path = ""
        }
        else {
             thumb_path = url.absoluteString
        }
        
        
        
        Indicator.sharedInstance.showIndicator()
        
        UserVM.shared.registerEvent(event_city: regionTextField.text!, create_date: date_result, event_des: eventTextField.text! , event_phone: phoneSettingTextField.text!, event_title: eventTitleField.text!, event_type: eventTypeLabel.text!, user_age: user_age!, user_avatar: user_avatar![0], user_city: regionTextField.text!, user_gender: user_gender!, user_job: user_job!, user_name: user_name!, user_style: user_style!, user_tall: user_tall!, user_id: user_id!, created_at: "", row_key: row_key, source_type: source_type!, thumb_path: thumb_path, views_counts: "0" ) { (success, message, error) in
             
            Indicator.sharedInstance.hideIndicator()
            if error == nil{
                if success{
                    self.showAlert(message: "이벤트가 성과적으로 등록되였습니다.")
                    self.regionTextField.text = ""
                    self.eventTextField.text = ""
                    self.phoneSettingTextField.text = ""
                    self.eventTitleField.text = ""
                    self.eventTypeLabel.text = ""
                    self.imageShowView.isHidden = true
                    self.imageSelectView.alpha = 1
                }else{
                    self.showAlert(message: message)
                }
            }else{
                self.showAlert(message: error?.localizedDescription)
            }
             
        }
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




extension createpostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet(){
            let title = "이미지 압로드 옵션"

            let popup = PopupDialog(title: title, message: "")

            let buttonOne = DefaultButton(title: "카메라", dismissOnTap: true) {
                self.showImagePickerController(sourceType: .camera)
            }

            let buttonTwo = DefaultButton(title: "이미지 갤러리", dismissOnTap: true) {
                
                self.showImagePickerController(sourceType: .photoLibrary)
            }

            let buttonThree = CancelButton(title: "취소", height: 60) {
               
            }
            popup.addButtons([buttonOne, buttonTwo, buttonThree])

            self.present(popup, animated: true, completion: nil)
        }
        
        func showImagePickerController(sourceType:UIImagePickerController.SourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            video_url = info[.mediaURL] as? URL
            
            if video_url != nil {
                SettingVM.shared.getThumbnailImageFromVideoUrl(url: video_url!) { (thumbImage) in
                let video_thumbImage = thumbImage
                    self.imageShowView.image = video_thumbImage
                    self.imageShowView.isHidden = false
                    self.imageSelectView.alpha = 0
                    self.media = "video"
                }
            }
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageShowView.image = editedImage
                imageShowView.isHidden = false
                imageSelectView.alpha = 0
                media = "image"
                
            }
            else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageShowView.image = originalImage
                imageShowView.isHidden = false
                imageSelectView.alpha = 0
                media = "image"
              
            }
            dismiss(animated: true, completion: nil)
        }
}
