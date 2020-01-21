//
//  searchVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class searchVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilesearchBtn: UIButton!
    @IBOutlet weak var nicknamesearchBtn: UIButton!
    
    let properties_profile: [String] = ["성별", "출생지", "년령", "신체", "스타일", "직업", "이미지", "흥미있는"]
    let values_profile: [String] = ["녀성", "장춘", "19세", "다부진형", "매력", "프로그래머", "미남", "게임"]
    let properties_nickname: [String] = ["성별", "년령", "거주지", "닉네임"]
    let values_nickname: [String] = ["녀성", "19세 ~ 21세", "장춘", "따영"]
    
    var searchType: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "프로필 검색"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let backButton = UIBarButtonItem()
        backButton.title = "뒤로"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        searchType = "profile"
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        tableView.reloadData()
    }
    @IBAction func profilesearchBtnTapped(_ sender: Any) {
        
        profilesearchBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        profilesearchBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        nicknamesearchBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nicknamesearchBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "profile"
        self.tableView.reloadData()
    }
    
    @IBAction func nicknamesearchBtnTapped(_ sender: Any) {
        
        nicknamesearchBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        nicknamesearchBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        profilesearchBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profilesearchBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "nickname"
        self.tableView.reloadData()
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
        
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        
    }
  
   

}
extension searchVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchType == "profile" {
            return properties_profile.count
        }
        else {
            return properties_nickname.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchType == "profile" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            cell.property?.text = self.properties_profile[indexPath.row]
            cell.value?.text = self.values_profile[indexPath.row]
            let item = properties_profile[indexPath.row]

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            cell.property?.text = self.properties_nickname[indexPath.row]
            cell.value?.text = self.values_nickname[indexPath.row]
            let item = properties_nickname[indexPath.row]

            return cell
        }
        
    }
    
    
    
}
