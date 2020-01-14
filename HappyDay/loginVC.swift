//
//  loginVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var gotodomain: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.green
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "로그인"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        gotodomain.addGestureRecognizer(tapGesture)

        
        // Do any additional setup after loading the view.
    }
    @objc func clickView(_ sender: UIView) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
       navigationController?.pushViewController(VC, animated: true)
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


