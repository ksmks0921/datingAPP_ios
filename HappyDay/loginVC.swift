//
//  loginVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol loginVCDelegate
{
    func selectDomainDismiss(domain: String)
}



class loginVC: UIViewController {

    @IBOutlet weak var gotodomain: UIView!
    @IBOutlet weak var domainLabel: UILabel!
    var domain: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "로그인"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectDomain(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        gotodomain.addGestureRecognizer(tapGesture)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }

    
    @objc func selectDomain(_ sender: UIView) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
       VC.delegate = self
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
extension loginVC: loginVCDelegate {
    
    func selectDomainDismiss(domain: String) {
        self.domainLabel.text = domain
    }
    
    
}


