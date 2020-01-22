//
//  signUpVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol ExamplePopupDelegate
{
    func ExamplePopupWillDismissForLocation(location: String)
    
    func ExamplePopupWillDismissForAge(age: String)
}

class signUpVC: UIViewController {

    let domains: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    var selectedElement = [Int : String]()
    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var regionUIView: DesinableView!
    @IBOutlet weak var ageUIView: DesinableView!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordAgainTxt: UITextField!
    var delegate: ExamplePopupDelegate? = nil
    var gender: Bool!
    var selectedImage = UIImage(named: "sharp_check_white_18dp")?.withRenderingMode(.alwaysTemplate)
    var location: String?
    var age:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "간단한 계정창조"
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView_1(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        regionUIView.addGestureRecognizer(tapGesture)
        
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(clickView_2(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        ageUIView.addGestureRecognizer(tapGesture_1)
        

    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           navigationController?.setNavigationBarHidden(true, animated: animated)
          
                   
       }
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickView_1(_ sender: UIView) {
        
          guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "BottomeSelectVC") as? BottomeSelectVC else { return }
          popupVC.height = 600
          popupVC.topCornerRadius = 10
          popupVC.presentDuration = 1
          popupVC.dismissDuration = 1
          popupVC.shouldDismissInteractivelty = true
          popupVC.popupDelegate = self
//          popupVC.previousVC = self
          popupVC.delegate = self
          popupVC.location_age = "location"
          present(popupVC, animated: true, completion: nil)
    }
    @objc func clickView_2(_ sender: UIView) {
        
          guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "BottomeSelectVC") as? BottomeSelectVC else { return }
          popupVC.height = 440
          popupVC.topCornerRadius = 10
          popupVC.presentDuration = 1
          popupVC.dismissDuration = 1
          popupVC.shouldDismissInteractivelty = true
          popupVC.popupDelegate = self
//          popupVC.previousVC = self
          popupVC.delegate = self
          popupVC.location_age = "age"
          present(popupVC, animated: true, completion: nil)
    }
    @IBAction func manSelect(_ sender: Any) {
        manBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        manBtn.setImage(selectedImage, for: .normal)
        womanBtn.setImage(nil, for: .normal)
        womanBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.gender = true
    }
    @IBAction func womanSelect(_ sender: Any) {
        womanBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
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
extension signUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.domains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
       cell.label?.text = self.domains[indexPath.row]
       let item = domains[indexPath.row]

       if item == selectedElement[indexPath.row] {
          cell.radioBtn.isSelected = true
       } else {
          cell.radioBtn.isSelected = false
       }
       cell.initCellItem()
       return cell

    }
    
    
}

extension signUpVC: ExamplePopupDelegate {
    func ExamplePopupWillDismissForLocation(location: String) {
        self.regionLabel.text = location
        print(location)
    }
    
    func ExamplePopupWillDismissForAge(age: String) {
        self.ageLabel.text = age
        print(age)
    }

        
}
