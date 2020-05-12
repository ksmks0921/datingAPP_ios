//
//  facebookLoginVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class facebookLoginVC: UIViewController {

    
  
    @IBOutlet weak var cancelBtn: DesinableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//
//        if #available(iOS 13.0, *) {
//            let app = UIApplication.shared
//            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
//
//            let statusbarView = UIView()
//            statusbarView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//            view.addSubview(statusbarView)
//
//            statusbarView.translatesAutoresizingMaskIntoConstraints = false
//            statusbarView.heightAnchor
//                .constraint(equalToConstant: statusBarHeight).isActive = true
//            statusbarView.widthAnchor
//                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
//            statusbarView.topAnchor
//                .constraint(equalTo: view.topAnchor).isActive = true
//            statusbarView.centerXAnchor
//                .constraint(equalTo: view.centerXAnchor).isActive = true
//
//        } else {
//            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//            statusBar?.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        }
        
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancel(_:)))
         tapGesture.delegate = self as? UIGestureRecognizerDelegate
         cancelBtn.addGestureRecognizer(tapGesture)
    }
    @objc func cancel(_ sender: UIView) {
        print("ttttt")
       _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func facebookLoginBtnTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }



}
