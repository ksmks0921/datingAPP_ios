//
//  mainProfileVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class mainProfileVC: UIViewController {

    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var publicProfileViewBtn: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageCover: DesinableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var settingBtn: UIView!
    
    let properties_profile: [String] = ["기본 프로필", "프로필 소개문", "외모", "직업관련", "라이흐 스타일"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")

        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(settingBtnTapped(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        settingBtn.isUserInteractionEnabled = true
        settingBtn.addGestureRecognizer(tapGesture_1)
    }
    
    @objc func settingBtnTapped(_ sender: UIView) {
        
                
    }

}
extension mainProfileVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return properties_profile.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            cell.property?.text = self.properties_profile[indexPath.row]
          
            let item = properties_profile[indexPath.row]

            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let VC = self.storyboard?.instantiateViewController(withIdentifier: "mainProfileItemVC") as! mainProfileItemVC
                if indexPath.row == 0 {
                    VC.items = ["별명", "나이", "별자리", "피형", "___", "잘노는 지역", "출생지", ""]
                    VC.values = ["김미선", "26", "처녀좌", "B", "___", "베이징", "선택하세요", "모두에게 공개"]
                    VC.pageIndex = "main"
                }
                else if indexPath.row == 1 {
                    
                }
                else if indexPath.row == 2 {
                    VC.items = ["스타일", "체중", "당신의 형태", "눈"]
                    VC.values = ["스타일", "75", "당신의 형태", "Black"]
                    VC.pageIndex = "style"
                }
                else if indexPath.row == 3 {
                     VC.items = ["직업", "", "년봉", ""]
                     VC.values = ["programmer", "", "5000", ""]
                     VC.pageIndex = "job"
                }
                else if indexPath.row == 4 {
                     VC.items = ["담배", "술", "여가시간", "교재 인원수"]
                     VC.values = ["no", "no", "football", "10"]
                     VC.pageIndex = "life"
                }
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    
}
