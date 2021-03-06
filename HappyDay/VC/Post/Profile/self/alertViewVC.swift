//
//  mainProfileItemVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class alertViewVC: UIViewController {

  
    @IBOutlet weak var alarmsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var items = [alarm]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.alarmsTableView.backgroundColor = UIColor.white
        // register tableView
         let nib = UINib.init(nibName: "alarmViewCell", bundle: nil)
         self.alarmsTableView.register(nib, forCellReuseIdentifier: "alarmViewCell")
         
        items = [alarm(title: "alarm_1", content: "This is test alarm!", time: "05/07/08/26"),
        alarm(title: "alarm_1", content: "This is test alarm!", time: "05/07/08/26")]
        alarmsTableView.reloadData()
      
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
        navigationController?.popViewController(animated: true)
    }
    
    


}


extension alertViewVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = alarmsTableView.dequeueReusableCell(withIdentifier: "alarmViewCell", for: indexPath as IndexPath) as! alarmViewCell
           
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Item is clicked!")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    
}
