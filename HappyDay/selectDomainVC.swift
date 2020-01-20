//
//  selectDomainVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class selectDomainVC: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    let domains: [String] = ["@gmail.com", "@hotmail.com", "@yandex.com", "@outlook.com", "@123.com"]
    var domain: String?
    let cellReuseIdentifier = "cell"
    var selectedElement = [Int : String]()
    var delegate: loginVCDelegate?
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "도메인 선택"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "MyCustomCell")
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.selectDomainDismiss(domain: domains[selectedIndex!.row] )
    }

}
extension selectDomainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.domains.count
       }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     
       let cell = tableview.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
       cell.label?.text = self.domains[indexPath.row]
          
       if (selectedIndex == indexPath) {
          cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_checked_black_18dp"),for:.normal)
             } else {
          cell.radioBtn.setImage(UIImage(named: "sharp_radio_button_unchecked_black_18dp"),for:.normal)
       }
      
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        tableview.reloadData()
    }
       
}
