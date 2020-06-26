//
//  otherSettingVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class otherSettingVC: BottomPopupViewController {
    
    @IBOutlet weak var userinfotableview: UITableView!

    
    var items = [String]()
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    @IBOutlet weak var heightOfTable: NSLayoutConstraint!
    var height_cell = 60
    var index_type = 0
    var delegate : SearchTypeDelegate?
    var default_green_color = #colorLiteral(red: 0.2588235294, green: 0.7294117647, blue: 0.1058823529, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "profileTableViewCell", bundle: nil)
        self.userinfotableview.register(nib, forCellReuseIdentifier: "profileTableViewCell")
        
        let height_view = self.view.frame.height
        let height_table = (items.count + 1) * height_cell
        
   
        if  height_table > Int(height_view) {
            
            heightOfTable.constant = CGFloat(height_view - 50)
            
        }
        else {
           
            heightOfTable.constant = CGFloat((items.count + 1) * height_cell)
            
        }
        
        
    }
    
    override func getPopupHeight() -> CGFloat {
         return height ?? CGFloat(300)
     }
     
     override func getPopupTopCornerRadius() -> CGFloat {
         return topCornerRadius ?? CGFloat(10)
     }
     
     override func getPopupPresentDuration() -> Double {
         return presentDuration ?? 1.0
     }
     
     override func getPopupDismissDuration() -> Double {
         return dismissDuration ?? 1.0
     }
     
     override func shouldPopupDismissInteractivelty() -> Bool {
         return shouldDismissInteractivelty ?? true
     }
   

}


extension otherSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1 //add cancel button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userinfotableview.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as! profileTableViewCell
        cell.valueLabel.isHidden = true
        
        if indexPath.row == items.count {
            cell.contentView.backgroundColor = default_green_color
            cell.propertyLabel.text = "キャンセル"
        }
        else {
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.propertyLabel.text = self.items[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(height_cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == items.count {
            dismiss(animated: true, completion: nil)
        }
        else {
            dismiss(animated: true, completion: nil)
            delegate?.selectSearchType(index: self.index_type ,type: items[indexPath.row])
        }
            
       
    }
    
    
    
    
}
