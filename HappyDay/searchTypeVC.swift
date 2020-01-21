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
    
    let search_type: [String] = ["성별", "검색 지역", "거주지", "게시판 기본검색", "년령", "신체", "스타일", "외모", "직업", "이미지", "동영상"]
    let values_profile: [String] = ["녀성", "장춘", "장춘", "나이", "19세", "매력", "매력스타일", "미남", "게임머", "이미지1", "동영상1"]
    let properties_nickname: [String] = ["성별", "년령", "거주지", "닉네임"]
    let values_nickname: [String] = ["녀성", "19세 ~ 21세", "장춘", "따영"]
    
    var searchType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        searchType = "searchType"
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        tableView.reloadData()
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }

    @IBAction func serachTypeBtnTapped(_ sender: Any) {
        searchTypeBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        saveBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "searchType"
        self.tableView.reloadData()
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        saveBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        searchTypeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = "searchType_save"
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
        if searchType == "searchType" {
            return search_type.count
        }
        else {
            return properties_nickname.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchType == "searchType" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            cell.property?.text = self.search_type[indexPath.row]
            cell.value?.text = self.values_profile[indexPath.row]
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                cell.value?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            else {
                cell.value?.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            cell.property?.text = self.properties_nickname[indexPath.row]
            cell.value?.text = self.values_nickname[indexPath.row]
            return cell
        }
        
    }
    
    
    
}
