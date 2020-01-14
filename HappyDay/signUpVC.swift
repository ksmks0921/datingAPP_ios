//
//  signUpVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {

    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var regionUIView: DesinableView!
    @IBOutlet weak var ageUIView: DesinableView!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordAgainTxt: UITextField!
    
    var gender: Bool!
    var selectedImage = UIImage(named: "sharp_check_white_18dp")?.withRenderingMode(.alwaysTemplate)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        regionUIView.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func clickView(_ sender: UIView) {
        print("hhhhhhh")
          guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "ExamplePopupViewController") as? ExamplePopupViewController else { return }
              popupVC.height = 400
              popupVC.topCornerRadius = 10
              popupVC.presentDuration = 1
              popupVC.dismissDuration = 1
              popupVC.shouldDismissInteractivelty = true
              popupVC.popupDelegate = self
              //navigationController?.pushViewController(popupVC, animated: true)
              present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func manSelect(_ sender: Any) {
        manBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        manBtn.setImage(selectedImage, for: .normal)
        womanBtn.setImage(nil, for: .normal)
        womanBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.gender = true
    }
    @IBAction func womanSelect(_ sender: Any) {
        womanBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        womanBtn.setImage(selectedImage, for: .normal)
        manBtn.setImage(nil, for: .normal)
        manBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.gender = false
    }
    
    @IBAction func goNextBtn(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension signUpVC: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
