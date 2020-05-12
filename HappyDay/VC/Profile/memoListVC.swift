//
//  memoListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol memoListVCDelegate
{
    func selectCategoryDismiss(category: String)
}

class memoListVC: UIViewController {
    
    @IBOutlet weak var selectCategoryView: DesinableView!
    @IBOutlet weak var editCategoryBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var categorySelected: UILabel!
    @IBOutlet weak var editMemoTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCategory(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        selectCategoryView.addGestureRecognizer(tapGesture)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    @objc func selectCategory(_ sender: UIView) {
        // goto selectDomainVC and get data
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
        VC.delegate_momolist = self
        VC.page_from = "momoList"
   
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }


}
extension memoListVC: memoListVCDelegate {
    
    func selectCategoryDismiss(category: String) {
        self.categorySelected.text = category
    }
    
    
}
