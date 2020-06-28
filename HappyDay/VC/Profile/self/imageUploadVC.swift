//
//  imageUploadVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import PopupDialog
import FirebaseStorage

class imageUploadVC: BaseVC {

    
    @IBOutlet weak var imageUploadView_1: DesinableView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageUploadView_2: DesinableView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageUploadView_3: DesinableView!
    @IBOutlet weak var imageView3: UIImageView!
    
    var image_index:Int?
    var avatars = [String]()
    var user: person!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_1(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        imageUploadView_1.addGestureRecognizer(tapGesture_1)
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_2(_:)))
        tapGesture_2.delegate = self as? UIGestureRecognizerDelegate
        imageUploadView_2.addGestureRecognizer(tapGesture_2)
        
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_3(_:)))
        tapGesture_3.delegate = self as? UIGestureRecognizerDelegate
        imageUploadView_3.addGestureRecognizer(tapGesture_3)
        
        let tapGesture_4 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_1(_:)))
        tapGesture_4.delegate = self as? UIGestureRecognizerDelegate
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGesture_4)
        
        let tapGesture_5 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_2(_:)))
        tapGesture_5.delegate = self as? UIGestureRecognizerDelegate
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGesture_5)
        
        let tapGesture_6 = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoTapped_3(_:)))
        tapGesture_6.delegate = self as? UIGestureRecognizerDelegate
        imageView3.isUserInteractionEnabled = true
        imageView3.addGestureRecognizer(tapGesture_6)
        
        
        if UserVM.current_user != nil {
            user = UserVM.current_user
            avatars = user.user_avatar!
        }
        if avatars[0] != AppConstant.defatul_image_url {

            imageView1.isHidden = false
            imageView1.sd_setImage(with: URL(string: avatars[0]))
          
        }
        print("______here\(avatars[1])")
        print("______here\(avatars[2])")
        if avatars[1] != AppConstant.defatul_image_url {

            imageView2.isHidden = false
            imageView2.sd_setImage(with: URL(string: avatars[1]))
          
        }
        
        if avatars[2] != AppConstant.defatul_image_url {

            imageView3.isHidden = false
            imageView3.sd_setImage(with: URL(string: avatars[2]))
          
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }
        
  

    @objc func uploadPhotoTapped_1(_ sender: UIView) {
        self.image_index = 1
        showImagePickerControllerActionSheet()
                
    }
    @objc func uploadPhotoTapped_2(_ sender: UIView) {
        self.image_index = 2
        showImagePickerControllerActionSheet()
    }
    @objc func uploadPhotoTapped_3(_ sender: UIView) {
        self.image_index = 3
        showImagePickerControllerActionSheet()
    }
    @IBAction func finishButtonTapped(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func savePhoto(url: URL, index: Int, completion: @escaping (Bool) -> Void) {
        
        let url_string = url.absoluteString
        self.avatars[index] = url_string
        let sex = { () -> Bool in
            if self.user.user_sex == "男性" {
                return true
            }
            else {
                return false
            }
        }
        UserVM.shared.updateUserData(city: user.user_city!, age: user.user_age!, job: user.user_job!, blood: user.user_blood!, star: user.user_star!, tall: user.user_tall!, user_style: user.user_style!, life_style: user.user_lifestyle!, user_outside: user.user_outside!, sex: sex(), nick_name: user.user_nickName!, style_1: user.style_1!, style_2: user.style_2!, style_3: user.style_3!, style_4: user.style_4!, require_age: user.required_age!, is_approved: user.is_approved!, updated_at: user.updated_at!, created_at: user!.created_at!, require_style: user.require_style!, require_tall: user.require_tall!, status: user!.user_status!, introduce: user!.user_introduce!, date: user!.user_date!, user_avatar: self.avatars) {(success, message, error) in
                   if error == nil {
                       if success {
                            completion(true)
                           
                       }
                       else {
                           self.showAlert(message: "error")
                       }
                   }
                   else {
                       print(error)
                   }
                   
        }
        
    }
    func uploadImage(image_index: Int, imageData: UIImage, completion: @escaping (Bool) -> Void) {
        
               Indicator.sharedInstance.showIndicator()
               let storageRef = Storage.storage().reference().child("media").child(UUID().uuidString)
                    if let uploadData = imageData.pngData() {
                   
                   storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                       Indicator.sharedInstance.hideIndicator()
                       if error != nil {
                           print("error")
                           
                       } else {
                           storageRef.downloadURL { (url, error) in
                            guard let downloadURL = url else {return}
                               
                            self.savePhoto(url: downloadURL, index: image_index, completion: {_ in
                                completion(true)
                            })
                            
                   
                           }
        
                       }
                   }
        }
        
        
    }
    
    

}

extension imageUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet(){
        let title = "画像のアップロード"

        let popup = PopupDialog(title: title, message: "")

        let buttonOne = DefaultButton(title: "カメラで撮影", dismissOnTap: true) {
            self.showImagePickerController(sourceType: .camera)
        }

        let buttonTwo = DefaultButton(title: "ライブラリから選ぶ", dismissOnTap: true) {
            
            self.showImagePickerController(sourceType: .photoLibrary)
        }

        let buttonThree = CancelButton(title: "キャンセル", height: 60) {
           
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
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if self.image_index == 1 {
                imageUploadView_1.isHidden = true
                imageView1.isHidden = false
                self.uploadImage(image_index: 0, imageData: editedImage, completion: {_ in
                    self.imageView1.image = editedImage
                })
                
            }
            else if self.image_index == 2 {
                imageUploadView_2.isHidden = true
                imageView2.isHidden = false
                self.uploadImage(image_index: 1, imageData: editedImage, completion: {_ in
                    self.imageView2.image = editedImage
                })
            }
            else {
                imageUploadView_3.isHidden = true
                imageView3.isHidden = false
                self.uploadImage(image_index: 2, imageData: editedImage, completion: {_ in
                    self.imageView3.image = editedImage
                })
            }
            
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if self.image_index == 1 {
                imageUploadView_1.isHidden = true
                imageView1.isHidden = false
                self.uploadImage(image_index: 0, imageData: originalImage, completion: {_ in
                    self.imageView2.image = originalImage
                })
            }
            else if self.image_index == 2 {
                imageUploadView_2.isHidden = true
                imageView2.isHidden = false
                self.uploadImage(image_index: 1, imageData: originalImage, completion: {_ in
                    self.imageView2.image = originalImage
                })
            }
            else {
                imageUploadView_3.isHidden = true
                imageView3.isHidden = false
                self.uploadImage(image_index: 2, imageData: originalImage, completion: {_ in
                    self.imageView3.image = originalImage
                })
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
