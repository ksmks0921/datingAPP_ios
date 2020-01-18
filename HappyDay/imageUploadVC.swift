//
//  imageUploadVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import PopupDialog

class imageUploadVC: UIViewController {

    
    @IBOutlet weak var imageUploadView_1: DesinableView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageUploadView_2: DesinableView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageUploadView_3: DesinableView!
    @IBOutlet weak var imageView3: UIImageView!
    
    var image_index:Int?
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
       
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       navigationController?.setNavigationBarHidden(false, animated: animated)
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
  

}

extension imageUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if self.image_index == 1 {
                imageUploadView_1.isHidden = true
                imageView1.isHidden = false
                imageView1.image = editedImage
            }
            else if self.image_index == 2 {
                imageUploadView_2.isHidden = true
                imageView2.isHidden = false
                imageView2.image = editedImage
            }
            else {
                imageUploadView_3.isHidden = true
                imageView3.isHidden = false
                imageView3.image = editedImage
            }
            
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if self.image_index == 1 {
                imageUploadView_1.isHidden = true
                imageView1.isHidden = false
                imageView1.image = originalImage
            }
            else if self.image_index == 2 {
                imageUploadView_2.isHidden = true
                imageView2.isHidden = false
                imageView2.image = originalImage
            }
            else {
//                imageUploadView_3.isHidden = true
                imageView3.isHidden = false
                imageView3.image = originalImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
