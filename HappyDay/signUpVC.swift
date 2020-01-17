//
//  signUpVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class signUpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
       let domains: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
       var selectedElement = [Int : String]()
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.domains.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
                  cell.label?.text = self.domains[indexPath.row]
                  //let deselectedImage = UIImage(named: "sharp_radio_button_unchecked_black_18dp")?.withRenderingMode(.alwaysTemplate)
                  //cell.radioBtn.setImage(deselectedImage, for: .normal)

                  let item = domains[indexPath.row]

                     if item == selectedElement[indexPath.row] {
                         cell.radioBtn.isSelected = true
                     } else {
                         cell.radioBtn.isSelected = false
                     }
                     cell.initCellItem()




           return cell

       }
    

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

    }
    
    
    @objc func clickView(_ sender: UIView) {
        
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
