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
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "로그인"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        gotodomain.addGestureRecognizer(tapGesture)

        
    }
    @objc func clickView(_ sender: UIView) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
       navigationController?.pushViewController(VC, animated: true)
   }

    @IBAction func facebookLogin(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "facebookLoginVC") as! facebookLoginVC
              navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func login(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                     navigationController?.pushViewController(VC, animated: true)
    }
    
  
    

}


