//
//  mainProfileItemVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class mainProfileItemVC: UIViewController {

  
    @IBOutlet weak var profileItemTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var items: [String]!
    var values: [String]!
    var pageIndex: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // register tableView
         let nib = UINib.init(nibName: "profileItemTableViewCell", bundle: nil)
         self.profileItemTableView.register(nib, forCellReuseIdentifier: "profileItemTableViewCell")
         
      
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    private func setupTitle(){
        
       if pageIndex == "main" {
           titleLabel.text = "기본 프로필"
       }
       else if pageIndex == "style" {
           titleLabel.text = "외모"
       }
       else if pageIndex == "job" {
           titleLabel.text = "직업관련"
       }
       else if pageIndex == "life" {
            titleLabel.text = "라이흐 스타일"
       }
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        if pageIndex == "main" {
            self.items = ["스타일", "체중", "당신의 형태", "눈"]
            self.values = ["스타일", "75", "당신의 형태", "Black"]
            self.pageIndex = "style"
            self.profileItemTableView.reloadData()
            setupTitle()
        }
        else if pageIndex == "style" {
            self.items = ["직업", "", "년봉", ""]
            self.values = ["programmer", "", "5000", ""]       
            self.pageIndex = "job"
            self.profileItemTableView.reloadData()
            setupTitle()
        }
        else if pageIndex == "job" {
            self.items = ["담배", "술", "여가시간", "교재 인원수"]
            self.values = ["no", "no", "football", "10"]
            self.pageIndex = "life"
            self.profileItemTableView.reloadData()
            setupTitle()
        }
    }
    


}


extension mainProfileItemVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = profileItemTableView.dequeueReusableCell(withIdentifier: "profileItemTableViewCell", for: indexPath as IndexPath) as! profileItemTableViewCell
            cell.property?.text = self.items[indexPath.row]
            cell.value?.text = self.values[indexPath.row]
            if indexPath.row == 4 || indexPath.row == 5 {
                cell.icon.image = #imageLiteral(resourceName: "outline_keyboard_arrow_right_black_18dp")
            }
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Item is clicked!")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    
}
