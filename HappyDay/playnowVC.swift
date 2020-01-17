//
//  playnowVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class playnowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnTap = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "지금부터 놀자"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
