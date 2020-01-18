//
//  footVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class footVC: UIViewController {

    @IBOutlet weak var footTableView: UITableView!
    @IBOutlet weak var todayFootLabel: DesinableView!
    @IBOutlet weak var allFootLabel: UILabel!
    @IBOutlet weak var footBtn: UIButton!
    @IBOutlet weak var selfFootBtn: UIButton!
    @IBOutlet weak var footView: UIView!
    
    let properties_profile: [String] = ["성별", "출생지", "년령", "신체", "스타일", "직업", "이미지", "흥미있는"]
    let values_profile: [String] = ["녀성", "장춘", "19세", "다부진형", "매력", "프로그래머", "미남", "게임"]
    let properties_nickname: [String] = ["성별", "년령", "거주지", "닉네임"]
    let values_nickname: [String] = ["녀성", "19세 ~ 21세", "장춘", "따영"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib.init(nibName: "footTableViewCell", bundle: nil)
        self.footTableView.register(nib, forCellReuseIdentifier: "footTableViewCell")
        footTableView.reloadData()

       
    }
    @IBAction func footBtnTapped(_ sender: Any) {
        footBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        footBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        selfFootBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selfFootBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
//        self.searchType = "profile"
        self.footTableView.reloadData()
        footView.isHidden = false
    }
    
    @IBAction func selfFootBtnTapped(_ sender: Any) {
        selfFootBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        selfFootBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        footBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        footBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
//        self.searchType = "profile"
        self.footTableView.reloadData()
        footView.isHidden = true
    }
    

}
extension footVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return properties_profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "footTableViewCell", for: indexPath as IndexPath) as! footTableViewCell
        cell.photo.image = UIImage(named: "first")
        let item = properties_profile[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}
