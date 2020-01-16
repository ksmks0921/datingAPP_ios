//
//  ExamplePopupViewController.swift
//  BottomPopup
//
//  Created by Emre on 16.09.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

class ExamplePopupViewController: BottomPopupViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let domains: [String] = ["상해", "베이징", "대련", "청도", "장춘"]
    var selectedElement = [Int : String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.domains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
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
    

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func finishBtnTapped(_ sender: Any) {
        
    }
    //    @IBAction func dismissButtonTapped(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
//    }
    
    // Bottom popup attribute methods
    // You can override the desired method to change appearance
    
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

