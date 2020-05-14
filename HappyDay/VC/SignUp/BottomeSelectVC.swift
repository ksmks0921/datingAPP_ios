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
//      let locations: [String] = ["상해", "베이징", "대련", "청도", "장춘","길림","천진", "홍콩", "연길", "길림"]
//      let ages: [String] = ["18세 ~ 20세", "20세 ~ 25세", "25세 ~ 35세", "35세 ~ 45세", "45세 ~ 60세"]
    
    
      
      var ages = [String]()
      var locations = [String]()
      var selectedIndex:IndexPath!

      var height: CGFloat?
      var topCornerRadius: CGFloat?
      var presentDuration: Double?
      var dismissDuration: Double?
      var shouldDismissInteractivelty: Bool?
    
      var location: String?
      var age:String?
      var delegate: ExamplePopupDelegate?
      var location_age: String?
      
      
      @IBAction func dismissButtonTapped(_ sender: Any) {
          dismiss(animated: true, completion: nil)
      }
      @IBAction func finishBtnTapped(_ sender: Any) {

          dismiss(animated: true, completion: nil)
          if self.location_age == "location"{

              delegate?.ExamplePopupWillDismissForLocation(location: locations[selectedIndex.row])
          }
          else {

              delegate?.ExamplePopupWillDismissForAge(age: ages[selectedIndex.row])
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
      
      override func viewDidLoad() {
          
          let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
          self.tableView.register(nib, forCellReuseIdentifier: "MyCustomCell")
          

      }
}


extension BottomeSelectVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.location_age == "location" {
            return self.locations.count
        }
        else {
            return self.ages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.location_age == "location"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.label?.text = self.locations[indexPath.row]

            if (selectedIndex == indexPath) {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
                   } else {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
            }



            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
            cell.label?.text = self.ages[indexPath.row]

            if (selectedIndex == indexPath) {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
                   } else {
                cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
            }



            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedIndex = indexPath as IndexPath
        tableView.reloadData()
         
    }
    
}
