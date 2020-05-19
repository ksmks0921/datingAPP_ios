//
//  noSeeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class personalPageItemVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    
    var items = [Like]()
    var titleText: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
        self.contentTable.register(nib, forCellReuseIdentifier: "chatTableCell")
        
       
        alertLabel.text = String(items.count) + "명을 기록하고 있습니다."
        titleLabel.text = titleText
        
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }


}
extension personalPageItemVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contentTable.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
       
        cell.photo.sd_setImage(with: URL(string: items[indexPath.row].like_avatar), placeholderImage: UIImage(named: "avatar_woman"))
        cell.name.text = items[indexPath.row].like_name
       
        cell.age_region_label.text = items[indexPath.row].like_age
        cell.last_chat_label.text = items[indexPath.row].like_city
        cell.statusView.isHidden = true
       
        cell.time_label.text = items[indexPath.row].like_date
       
        if items[indexPath.row].user_sex == true {
            cell.name.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
           
        }
        else {
            cell.name.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
