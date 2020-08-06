//
//  helpVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 6/24/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import QuickLook

class helpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let previewController = QLPreviewController()
        
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
   
    }

    @IBAction func okBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
