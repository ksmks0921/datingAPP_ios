//
//  selectDomainVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class selectDomainVC: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    let domains: [String] = ["@gmail.com", "@hotmail.com", "@yandex.com", "@outlook.com", "@123.com"]
    let categories: [String] = ["category_1", "category_2", "category_3", "category_4", "category_5"]
    var domain: String?
    let cellReuseIdentifier = "cell"
    var selectedElement = [Int : String]()
  
   
    
    var selectedIndex: Int?
    var page_from: String?
    @IBOutlet weak var custom_title: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUpTitle()
        selectedIndex = 0
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "MyCustomCell")
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setUpTitle(){
        if page_from == "login"{
            custom_title.text = "ドメイン選択"
       }
       else {
            custom_title.text = "카테고리 선택"
       }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
 
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension selectDomainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if page_from == "login"{
              return self.domains.count
        }
        else {
             return self.categories.count
        }
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableview.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
       
        if page_from == "login"{
           
           cell.label?.text = self.domains[indexPath.row]
              
            if (selectedIndex == indexPath.row) {
              cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
                 } else {
              cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
           }
          
           return cell
        }
        else {
            
             cell.label?.text = self.categories[indexPath.row]
                
            if (selectedIndex == indexPath.row) {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
                   } else {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
             }
            
             return cell
         }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        tableview.reloadData()
    }
       
}
