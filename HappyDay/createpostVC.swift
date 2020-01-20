//
//  createpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class createpostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "프로화일 검색"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let backButton = UIBarButtonItem()
        backButton.title = "뒤로"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

    }
    
   

}
