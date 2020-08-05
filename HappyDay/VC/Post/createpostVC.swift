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
import AVFoundation

class createpostVC: BaseVC, UITextFieldDelegate  {

    
//    @IBOutlet weak var eventTitleField: UITextField!
    
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
    @IBOutlet weak var contentScroll: UIScrollView!
    var media : String!
    var video_url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        self.eventTextField.delegate = self
        
 
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.contentScroll.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        contentScroll.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        contentScroll.contentInset = contentInset
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
    }
    func setupViewTap() {
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
        imageSelectView.addGestureRecognizer(tapGesture_image)
    }
    @objc func selectEventType(_ sender: UIView) {
        
        guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        var items = [String]()
        for i in 1...AppConstant.event_Type.count - 1 {
            items.append(AppConstant.event_Type[i])
        }
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
        popupVC.items = items
        popupVC.delegate = self
        popupVC.index_type = 0
        self.present(popupVC, animated: true, completion: nil)
        
    }
    @objc func selectEventCity(_ sender: UIView) {
        
         SettingVM.shared.getSelectingRegions(completion: {_ in
                   guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
                   let height_view = self.view.frame.size.height
                   let height_bottom_view = (SettingVM.RegionList.count + 1) * 60
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
        if imageShowView.image != nil {
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
                                    
                                    if self.media == "video" {
//                                        self.uploadTOFireBaseVideo(url: self.video_url, success: {(url) in
//                                            self.registerEvent(url: downloadURL, url_source: url)
//                                        }, failure: {(error) in
//                                            print(error)
//                                        })
                                        let storageRef_video = Storage.storage().reference().child("media").child(UUID().uuidString)
                                        storageRef_video.putFile(from: self.video_url as URL, metadata: nil) { (metadata, error) in
                                            print("_________ok________\(self.video_url)")
                                            if error != nil {
                                                print("error ocurred\(error)")

                                            } else {
                                                print("_________ok________\(downloadURL)")
                                                 storageRef_video.downloadURL { (url, error) in
                                                 guard let video_downloadURL = url else {return}
                                                    self.registerEvent(url: downloadURL, url_source: video_downloadURL.absoluteString)
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        self.registerEvent(url: downloadURL, url_source: "")
                                    }
                                       
                                       
                           
                                   }
                
                               }
                           }
                      }
            
        }
        else {
            self.showAlert(message: "画像或ビデオを選んでください")
        }
//        if eventTitleField.text == "" {
//            self.showAlert(message: "件名を記入下さい。")
//            return
//        }
        if regionTextField.text == "" {
            self.showAlert(message: "地域を選んでください")
            return
        }
        if phoneSettingTextField.text == "" {
            self.showAlert(message: "電話受付の設定を選択してください。")
            return
        }
        if eventTypeLabel.text == "" {
            self.showAlert(message: "イベント型を選択してください。")
            return
        }
        if eventTextField.text == "" {
            self.showAlert(message: "イベントの本文を入力してください。")
            
            return
        }
        
    }
    
    func registerEvent(url: URL, url_source: String) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date_result = formatter.string(from: date)
        
        let user_age = UserVM.current_user.user_age
        let user_avatar =  UserVM.current_user.user_avatar
        let user_gender: Bool!
        if UserVM.current_user.user_sex == "女性" {
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
        let source_type = self.media
        let thumb_path : String!
        let event_photo : String!
        if media == "image" {
             thumb_path = ""
             event_photo = url.absoluteString
        }
        else {
             thumb_path = url.absoluteString
             event_photo = url_source
        }
        
        print("event_photo___is_____\(event_photo)")
        
        let currentDateTime = Date()
        let created_at_temp = currentDateTime.timeIntervalSince1970
        let created_at = Int(created_at_temp * 1000)
        Indicator.sharedInstance.showIndicator()
        
        UserVM.shared.registerEvent(event_city: regionTextField.text!, create_date: date_result, event_des: eventTextField.text! ,event_photo: event_photo, event_phone: phoneSettingTextField.text!, event_type: eventTypeLabel.text!, user_age: user_age!, user_avatar: user_avatar![0], user_city: regionTextField.text!, user_gender: user_gender!, user_job: user_job!, user_name: user_name!, user_style: user_style!, user_tall: user_tall!, user_id: user_id!, created_at: created_at, source_type: source_type!, thumb_path: thumb_path, views_counts: "0" ) { (success, message, error) in
             
            Indicator.sharedInstance.hideIndicator()
            if error == nil{
                if success{
                    self.showAlert(message: "イベントが成功裏に登録されました。")
                    self.regionTextField.text = ""
                    self.eventTextField.text = ""
                    self.phoneSettingTextField.text = ""
                 
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
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

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
            let title = "画像アップオプション"

            let popup = PopupDialog(title: title, message: "")

            let buttonOne = DefaultButton(title: "カメラ", dismissOnTap: true) {
//                self.showImagePickerController(sourceType: .camera)
                ImagePicker.cameraMulti(target: self, edit: true)
            }
            let buttonThree = DefaultButton(title: "画像", dismissOnTap: true) {
                ImagePicker.photoLibrary(target: self, edit: true)
//                self.showImagePickerController(sourceType: .photoLibrary)
            }
            let buttonTwo = DefaultButton(title: "ビデオ", dismissOnTap: true) {
                ImagePicker.videoLibrary(target: self, edit: true)
            }
            

            let buttonFour = CancelButton(title: "キャンセル", height: 60) {
               
            }
            popup.addButtons([buttonOne, buttonTwo, buttonThree, buttonFour])

            self.present(popup, animated: true, completion: nil)
        }
        
        func showImagePickerController(sourceType:UIImagePickerController.SourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
//            imagePickerController.mediaTypes =  [kUTTypeImage as String, kUTTypeMovie as String]
            self.present(imagePickerController, animated: true, completion: nil)
        }
        func convertVideo(toMPEG4FormatForVideo inputURL: URL, outputURL: URL, handler: @escaping (AVAssetExportSession) -> Void) {
            try! FileManager.default.removeItem(at: outputURL as URL)
            let asset = AVURLAsset(url: inputURL as URL, options: nil)

            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            exportSession.exportAsynchronously(completionHandler: {
                handler(exportSession)
            })
        }
        func uploadTOFireBaseVideo(url: URL,
                                          success : @escaping (String) -> Void,
                                          failure : @escaping (Error) -> Void) {

            let name = "\(Int(Date().timeIntervalSince1970)).mp4"
            let path = NSTemporaryDirectory() + name

            let dispatchgroup = DispatchGroup()

            dispatchgroup.enter()

            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let outputurl = documentsURL.appendingPathComponent(name)
            var ur = outputurl
            self.convertVideo(toMPEG4FormatForVideo: url as URL, outputURL: outputurl) { (session) in

                ur = session.outputURL!
                dispatchgroup.leave()

            }
            dispatchgroup.wait()

            let data = NSData(contentsOf: ur as URL)

            do {

                try data?.write(to: URL(fileURLWithPath: path), options: .atomic)

            } catch {

                print(error)
            }

            let storageRef = Storage.storage().reference().child("Videos").child(name)
            if let uploadData = data as Data? {
                storageRef.putData(uploadData, metadata: nil
                    , completion: { (metadata, error) in
                        if let error = error {
                            failure(error)
                        }else{
                            storageRef.downloadURL { (url, error) in
                                success(url!.absoluteString)
                            }
//                            guard let downloadURL = url else {return}
//                            let strPic:String = (metadata)!
                            
                        }
                })
            }
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
//            video_url = info[.mediaURL] as? URL
            let temp_video_url = info[.mediaURL] as? URL
            if temp_video_url != nil {
                do {
                    if #available(iOS 13, *) {
                        //If on iOS13 slice the URL to get the name of the file
                        let urlString = temp_video_url!.relativeString
                        print("_____hello____\(temp_video_url)")
                        let urlSlices = urlString.split(separator: ".")
                        if urlSlices.count == 3 {
                            //Create a temp directory using the file name
                            let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                            let targetURL = tempDirectoryURL.appendingPathComponent(String(urlSlices[1])).appendingPathExtension(String(urlSlices[2]))

                            //Copy the video over
                            try FileManager.default.copyItem(at: temp_video_url!, to: targetURL)
                            print("______a is______")
                            self.video_url = targetURL
                        }
                        else {
                            self.video_url = temp_video_url
                        }
                        

                    }
                    else {
                        print("______b is______")
                        //If on iOS12 just use the original URL
                        picker.dismiss(animated: true) {
                            print("______c is______")
                            self.video_url = temp_video_url
                        }
                    }
                }
                catch let error {
                    //Handle errors
                }
            }
            
            if video_url != nil {
                print("______d is______")
                let asset = AVURLAsset(url: video_url!)
                print(asset.fileSize ?? 0)
                let size = asset.fileSize
                if size! > 60000000 {
                    self.showAlert(message: "ファイルは60M未満である必要があります。")
                }
                else {
                    SettingVM.shared.getThumbnailImageFromVideoUrl(url: video_url!) { (thumbImage) in
                                       
                       let video_thumbImage = thumbImage
                       self.imageShowView.image = video_thumbImage
                       self.imageShowView.isHidden = false
                       self.imageSelectView.alpha = 1
                       self.media = "video"
                   }
                }
               
            }
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageShowView.image = editedImage
                imageShowView.isHidden = false
                imageSelectView.alpha = 1
                media = "image"
                
            }
            else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageShowView.image = originalImage
                imageShowView.isHidden = false
                imageSelectView.alpha = 1
                media = "image"
              
            }
            dismiss(animated: true, completion: nil)
        }
}
extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)

        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}
