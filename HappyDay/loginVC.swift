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
     
        
        //select domain function
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectDomain(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        gotodomain.addGestureRecognizer(tapGesture)

    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }

    @IBAction func backBtnTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
    @objc func selectDomain(_ sender: UIView) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
       VC.delegate = self
       VC.page_from = "login"
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


