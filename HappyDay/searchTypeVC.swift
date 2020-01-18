//
//  searchTypeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class searchTypeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTypeBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    let properties_profile: [String] = ["성별", "출생지", "년령", "신체", "스타일", "직업", "이미지", "흥미있는"]
    let values_profile: [String] = ["녀성", "장춘", "19세", "다부진형", "매력", "프로그래머", "미남", "게임"]
    let properties_nickname: [String] = ["성별", "년령", "거주지", "닉네임"]
    let values_nickname: [String] = ["녀성", "19세 ~ 21세", "장춘", "따영"]
    
    var searchType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchType = "profile"
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func serachTypeBtnTapped(_ sender: Any) {
        searchTypeBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        saveBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "profile"
        self.tableView.reloadData()
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        saveBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        searchTypeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "save"
        self.tableView.reloadData()
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
    }
    @IBAction func TypeBtnTapped(_ sender: Any) {
    }
    


}
extension searchTypeVC:  UITableViewDelegate, UITableViewDataSource {
    
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
