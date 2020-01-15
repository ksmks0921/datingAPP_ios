//
//  selectDomainVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class selectDomainVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    let domains: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "cell"
    var selectedElement = [Int : String]()
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.domains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableview.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
        cell.label?.text = self.domains[indexPath.row]
        //let deselectedImage = UIImage(named: "sharp_radio_button_unchecked_black_18dp")?.withRenderingMode(.alwaysTemplate)
        //cell.radioBtn.setImage(deselectedImage, for: .normal)
       
        let item = domains[indexPath.row]
           
           if item == selectedElement[indexPath.row] {
               cell.radioBtn.isSelected = true
           } else {
               cell.radioBtn.isSelected = false
           }
           cell.initCellItem()
       
          
        
       
        return cell
    }
    
  


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "MyCustomCell")
        
    }
    

}
