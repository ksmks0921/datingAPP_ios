//
//  BottomeSelectVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/21/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class BottomeSelectVC: BottomPopupViewController {
    @IBOutlet weak var tableView: UITableView!

      var items = [String]()
      var height_row = 60
      var selectedIndex:IndexPath!

      var height: CGFloat?
      var topCornerRadius: CGFloat?
      var presentDuration: Double?
      var dismissDuration: Double?
      var shouldDismissInteractivelty: Bool?
 
      @IBOutlet weak var height_of_table: NSLayoutConstraint!
      var delegate: PopUpDelegate?
 
      
      
      @IBAction func dismissButtonTapped(_ sender: Any) {
          dismiss(animated: true, completion: nil)
      }
      @IBAction func finishBtnTapped(_ sender: Any) {

          dismiss(animated: true, completion: nil)
          

         delegate?.PopupWillDismissForData(data: items[selectedIndex.row])
         

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
      
      override func viewDidLoad() {
          
          let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
          self.tableView.register(nib, forCellReuseIdentifier: "MyCustomCell")
          
          let height_view = self.view.frame.height
          let height_table = items.count * AppConstant.height_60
          if  (height_table + 50) > Int(height_view) {
              height_of_table.constant = CGFloat(height_view - 100)
          }
          else {
              height_of_table.constant = CGFloat(items.count * AppConstant.height_60)
          }

      }
    
}


extension BottomeSelectVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.label?.text = self.items[indexPath.row]

            if (selectedIndex == indexPath) {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
                   } else {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
            }



            return cell
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.height_row)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedIndex = indexPath as IndexPath
        tableView.reloadData()
         
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
      
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
      
        
    }
}
