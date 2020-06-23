//
//  searchTypeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class searchTypeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTypeBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    let properties_nickname: [String] = ["性別", "居住地", "年齢", "身長", "スタイル",  "職業"]
    var search_typye_value_nick : [String] = ["全体", "全体", "全体", "全体", "全体", "全体"]
    
    let search_type: [String] = ["職業", "年齢", "居住地", "ニックネーム"]
    
    var search_typye_value : [String] = ["全体", "全体", "全体", "全体"]
    
    var height_of_table = 60
    var TallList = [String]()
    var StyleList = [String]()
    var JobList = [String]()
    var RegionList = [String]()
    var searchType: SearchType?
    var delegate: SearchPostDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getSettingData()
        searchType = .PROFILE
        print("___")
        print(searchType)
        
        
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        tableView.reloadData()
    }
    
    func getSettingData() {
        
        SettingVM.shared.getTallSetting(completion: {_ in
            self.TallList = SettingVM.AgeList
            print("Tall list added successfully!")
        })
        SettingVM.shared.getStyleSetting(completion: {_ in
            self.StyleList = SettingVM.AgeList
            
            print("Style list added successfully!")
        })
        
        SettingVM.shared.getJobSetting(completion: {_ in
            self.JobList = SettingVM.AgeList
            
            print("Job list added successfully!")
        })
        SettingVM.shared.getSelectingRegions(completion: {_ in
            self.RegionList = SettingVM.RegionList
            
            print("Cities list added successfully!")
        })
        SettingVM.shared.getSelectingAges(completion: {_ in
//            self.RegionList = SettingVM.RegionList
            
            print("Age list added successfully!")
        })
      
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }

    @IBAction func serachTypeBtnTapped(_ sender: Any) {
        searchTypeBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        saveBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = .PROFILE
        self.tableView.reloadData()
        print(searchType)
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        saveBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        searchTypeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchTypeBtn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)
        self.searchType = .NICKNAME
        self.tableView.reloadData()
        print(searchType)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
            Indicator.sharedInstance.showIndicator()
            
            switch self.searchType {
                case .PROFILE:
                    UserVM.shared.filterEvents(location: self.search_typye_value_nick[1], type: AppConstant.eAll, source_type: AppConstant.eAll, age: self.search_typye_value[2], tall: self.search_typye_value_nick[3], style: self.search_typye_value_nick[4], job: self.search_typye_value_nick[5], nick_name: AppConstant.eAll, completion: {_ in
                        
                            Indicator.sharedInstance.hideIndicator()
                            
                            DataManager.isShowingFilterResult = true
                            self.delegate.searchBtnTapped(data: true)
                            self.dismiss(animated: true, completion: nil)
                    })
                   
                case .NICKNAME:
                    
                    UserVM.shared.filterEvents(location: self.search_typye_value[2], type: AppConstant.eAll, source_type: AppConstant.eAll, age: self.search_typye_value[1], tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
                        
                            Indicator.sharedInstance.hideIndicator()
                            DataManager.isShowingFilterResult = true
                            self.delegate.searchBtnTapped(data: true)
                            self.dismiss(animated: true, completion: nil)
                            
                      
                    })
                    
                default:
                    break
            }
            
        
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
            switch self.searchType {
              case .PROFILE:
                  search_typye_value_nick = ["全体", "全体", "全体", "全体", "全体", "全体"]
                  
              case .NICKNAME:
                  
                  search_typye_value = ["全体", "全体", "全体", "全体"]
                  
              default:
                  break
              }
              
              tableView.reloadData()
        
    }
    @IBAction func TypeBtnTapped(_ sender: Any) {
        
        
    }
    


}
extension searchTypeVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch searchType {
        case .PROFILE:
            return properties_nickname.count
           
        case .NICKNAME:
            return search_type.count
            
         
        default:
            return 0
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchType {
            case .PROFILE:
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
                cell.property?.text = self.properties_nickname[indexPath.row]
                cell.value?.text = self.search_typye_value_nick[indexPath.row]
                cell.value.isHidden = false
                cell.inputTextField.isHidden = true
                cell.selectionStyle = .none
                
                
                cell.value?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                
                
                return cell
            case .NICKNAME:
                if indexPath.row == 3 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
                    cell.property?.text = self.search_type[indexPath.row]
                    cell.value.isHidden = true
                    cell.inputTextField.isHidden = false
                    cell.selectionStyle = .none
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
                    cell.value.isHidden = false
                    cell.inputTextField.isHidden = true
                    cell.selectionStyle = .none
                    cell.property?.text = self.search_type[indexPath.row]
                    cell.value?.text = self.search_typye_value[indexPath.row]
                    return cell
                }
            
            case .none:
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
          
                return cell
            
        }
            
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_50)
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
               break
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
        if height_bottom_view + 50 > Int(height_view) {
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
}
extension searchTypeVC: SearchTypeDelegate {
   
    
    func selectSearchType(index: Int, type: String) {
        
        let selected_item = type
        switch searchType {
        case .PROFILE:
            search_typye_value_nick[index] = selected_item
          
        case .NICKNAME:
            search_typye_value[index] = selected_item
        
        default:
            break
        }
        
        tableView.reloadData()
        print(selected_item)
        
    }
    
    
}
