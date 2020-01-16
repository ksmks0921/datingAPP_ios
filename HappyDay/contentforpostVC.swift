//
//  contentforpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView

class contentforpostVC: UIViewController {

   
    @IBOutlet weak var altertview: UIView!
    
    @IBOutlet weak var postTableView: UITableView!
    var pageType:Int?
    
    let properties_profile: [String] = ["성별", "출생지", "년령", "신체", "스타일", "직업", "이미지", "흥미있는"]
    let values_profile: [String] = ["녀성", "장춘", "19세", "다부진형", "매력", "프로그래머", "미남", "게임"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "게시판"
        
        let nib = UINib.init(nibName: "postTableViewCell", bundle: nil)
        self.postTableView.register(nib, forCellReuseIdentifier: "postTableViewCell")
        postTableView.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
      }

//      override func viewWillDisappear(_ animated: Bool) {
//          super.viewWillDisappear(animated)
//          navigationController?.setNavigationBarHidden(false, animated: animated)
//      }
    

}



extension contentforpostVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
extension contentforpostVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return properties_profile.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = postTableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! postTableViewCell
            cell.personPhoto.image = UIImage(named: "first")
            if self.pageType == 0 {
                cell.hopeTypeBack.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
            else if self.pageType == 1 {
                cell.hopeTypeBack.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
                
            }

            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
}
