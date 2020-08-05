//
//  memoListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit



class reportListVC: UIViewController {
    

    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var alertLabel: UILabel!
    var items = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView.backgroundColor = UIColor.white
        alertLabel.text = String(items.count) + "人からいいねされました"
    
    }
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
        if DataManager.isLockScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }
   
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }


}
extension reportListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellSwitch", for: indexPath as IndexPath) as! settingCellSwitch
        
           
       
            return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_50)
    }
}
