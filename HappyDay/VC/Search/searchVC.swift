//
//  searchVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol SearchTypeDelegate
{
    func selectSearchType(index: Int, type: String)

}


class searchVC: BaseVC {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilesearchBtn: UIButton!
    @IBOutlet weak var nicknamesearchBtn: UIButton!
    
    let search_type: [String] = ["性別", "居住地", "年齢", "身長", "スタイル",  "職業"]
    var search_typye_value : [String] = ["全体", "全体", "全体", "全体", "全体", "全体"]
    var search_typye_value_nick : [String] = ["全体", "全体", "全体", "全体"]
    let properties_nickname: [String] = ["職業", "年齢", "居住地", "ニックネーム"]

    var height_of_table = 60
    var searchType: SearchType?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        getSettingData()
        
        searchType = .PROFILE
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        tableView.reloadData()
        
    }
    
    func getSettingData() {
        SettingVM.shared.getTallSetting(completion: {_ in
           print("_________getTallSetting__________")
        })
        SettingVM.shared.getStyleSetting(completion: {_ in
            print("_________getStyleSetting__________")
            
        })
        SettingVM.shared.getJobSetting(completion: {_ in
            print("________getJobSetting___________")
           
        })
        SettingVM.shared.getSelectingAges(completion: {_ in
            print("________getSelectingAges___________")
           
        })
        SettingVM.shared.getSelectingRegions(completion: {_ in
            print("________getSelectingRegions___________")
           
        })
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
    @IBAction func profilesearchBtnTapped(_ sender: Any) {
        
        profilesearchBtn.backgroundColor = default_green_color
        profilesearchBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        nicknamesearchBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nicknamesearchBtn.setTitleColor(default_green_color, for: .normal)
        self.searchType = .PROFILE
        self.tableView.reloadData()
    }
    
    @IBAction func nicknamesearchBtnTapped(_ sender: Any) {
        
        nicknamesearchBtn.backgroundColor = default_green_color
        nicknamesearchBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        profilesearchBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profilesearchBtn.setTitleColor(default_green_color, for: .normal)
        self.searchType = .NICKNAME
        self.tableView.reloadData()
        
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
        switch self.searchType {
        case .PROFILE:
            search_typye_value = ["全体", "全体", "全体", "全体", "全体", "全体"]
            break
        case .NICKNAME:
            search_typye_value_nick = ["全体", "全体", "全体", "全体"]
            break
        default:
            break
        }
        
        tableView.reloadData()
        
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        Indicator.sharedInstance.showIndicator()
        switch searchType {
                case .PROFILE:
                 UserVM.shared.search(sex: search_typye_value[0], city: search_typye_value[1], age: search_typye_value[2], tall: search_typye_value[3], style: search_typye_value[4], job: search_typye_value[5], nick_name: search_typye_value_nick[3], completion: {_ in
                    
                    
                        Indicator.sharedInstance.hideIndicator()
                    
                        DataManager.isShowingSearchResult = true
                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                        self.navigationController?.pushViewController(VC, animated: true)
                    
                 })
                 break
                 case .NICKNAME:
                    UserVM.shared.search(sex: search_typye_value_nick[0], city: search_typye_value_nick[2], age: search_typye_value_nick[1], tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: search_typye_value_nick[3], completion: {_ in
                        
                        /////////////////////
                            Indicator.sharedInstance.hideIndicator()
                        
                            DataManager.isShowingSearchResult = true
                            let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                            self.navigationController?.pushViewController(VC, animated: true)
                        
                    })
                    break
                 default:
                 break
            }
            
    }
  
   

}
extension searchVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchType {
        case .PROFILE:
            return search_type.count
           
        case .NICKNAME:
            return properties_nickname.count
         
        default:
            return 0
           
        }
     
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_50)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchType {
        case .PROFILE:
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
                cell.property?.text = self.search_type[indexPath.row]
                cell.value?.text = search_typye_value[indexPath.row]
                cell.inputTextField.isHidden = true
                cell.value.isHidden = false
                return cell

        case .NICKNAME:
             if indexPath.row == properties_nickname.count - 1 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
               cell.property?.text = self.properties_nickname[indexPath.row]
               cell.inputTextField.isHidden = false
               cell.value.isHidden = true
               return cell
           }
           else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
               cell.property?.text = self.properties_nickname[indexPath.row]
               cell.value?.text = search_typye_value_nick[indexPath.row]
               cell.inputTextField.isHidden = true
               cell.value.isHidden = false
               return cell
           }
                      
         
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
                         
            return cell
        }
  
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchType {
        case .PROFILE:
            switch indexPath.row {
                case 0:
                    showSelectView(type_index: indexPath.row, items: ["男性", "女性"])
                    
                case 1:
                    showSelectView(type_index: indexPath.row, items: SettingVM.RegionList)
                    
                case 2:
                    showSelectView(type_index: indexPath.row, items: SettingVM.AgeList)
                    
                case 3:
                    showSelectView(type_index: indexPath.row, items: SettingVM.TallList)
                    
                case 4:
                    showSelectView(type_index: indexPath.row, items: SettingVM.StyleList)
                    
                case 5:
                    showSelectView(type_index: indexPath.row, items: SettingVM.JobList)
                    
                default:
                    break
            }
            
        case .NICKNAME:
            switch indexPath.row {
            case 0:
                showSelectView(type_index: indexPath.row, items: ["男性", "女性"])
                
            case 1:
                showSelectView(type_index: indexPath.row, items: SettingVM.AgeList)
                
            case 2:
                showSelectView(type_index: indexPath.row, items: SettingVM.RegionList)
                
                      
            default:
                break
            }
        default:
            break
            

        }
    }
    
    func showSelectView(type_index: Int, items: [String]) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        
        let height_view = self.view.frame.size.height
        let height_bottom_view = (items.count + 1) * height_of_table
        if height_bottom_view > Int(height_view) {
            popupVC.height = CGFloat(height_view - 80)
        }
        else {
            popupVC.height = CGFloat(height_bottom_view)
            
        }
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.items = items
        popupVC.delegate = self
        popupVC.index_type = type_index
        present(popupVC, animated: true, completion: nil)
        
    }
    func updateTableData() {
        
    }
}
extension searchVC: SearchTypeDelegate {
   
    
    func selectSearchType(index: Int, type: String) {
        
        let selected_item = type
        switch searchType {
        case .PROFILE:
            search_typye_value[index] = selected_item
            break
        case .NICKNAME:
            search_typye_value_nick[index] = selected_item
            break
        default:
            break
        }
        
        tableView.reloadData()
        print(selected_item)
        
    }
    
    
}
