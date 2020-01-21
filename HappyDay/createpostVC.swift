//
//  createpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class createpostVC: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var subjectView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    @IBAction func backBtnTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       navigationController?.setNavigationBarHidden(true, animated: animated)
      
               
    }
   

}
