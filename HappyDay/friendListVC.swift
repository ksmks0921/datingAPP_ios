//
//  friendListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class friendListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func createFriendBtnTapped(_ sender: Any) {
    }
    @IBAction func friendBtnTapped(_ sender: Any) {
    }
    @IBAction func waitBtnTapped(_ sender: Any) {
    }
    @IBAction func agreeWatiBtnTapped(_ sender: Any) {
    }

}
