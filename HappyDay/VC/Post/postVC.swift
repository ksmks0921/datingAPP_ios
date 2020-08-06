//
//  postVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView



protocol SearchPostDelegate
{
    func searchBtnTapped(data: Bool)
    
}

class postVC: BaseVC {
    
    
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    @IBOutlet weak var tabview: UIView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var allSectBtn: RoundButton!
    @IBOutlet weak var imageSelectBtn: RoundButton!
    
    @IBOutlet weak var videoSelectBtn: RoundButton!
    
    var selected_type = AppConstant.eAll
    var selected_source_type = AppConstant.eAll
    var selected_location = AppConstant.eAll
    var titles = AppConstant.eType
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
 
    }
    func setupUI() {
       let tempdataSource = JXSegmentedTitleDataSource()
       tempdataSource.isTitleColorGradientEnabled = false
       tempdataSource.titles = titles
       tempdataSource.titleSelectedColor = UIColor.white
       segmentedDataSource = tempdataSource
       DataManager.isShowingFilterResult = false
   
       
    
       let indicator = JXSegmentedIndicatorLineView()
       indicator.indicatorHeight = 40
       indicator.indicatorWidthIncrement = 30
       indicator.layer.cornerRadius = 8
       indicator.indicatorColor = default_green_color
       
       
       segmentedView.indicators = [indicator]


       segmentedView.dataSource = segmentedDataSource
       segmentedView.delegate = self
    }
    @IBAction func selectRegionTapped(_ sender: Any) {
        
        
        SettingVM.shared.getSelectingRegions(completion: {_ in
            guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }

            
            let height_view = self.view.frame.size.height
            let height_bottom_view = (SettingVM.RegionList.count + 1) * 60
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
            popupVC.items = SettingVM.RegionList
            popupVC.delegate = self
            popupVC.index_type = 0  // for using searchType delegate..... possible to ignore this
            self.present(popupVC, animated: true, completion: nil)
        })

    }
   
    @IBAction func allSelectTapped(_ sender: Any) {
        DataManager.isShowingFilterResult = true
        allSectBtn.backgroundColor = default_green_color
        allSectBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        imageSelectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageSelectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        videoSelectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        videoSelectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.selected_source_type = AppConstant.eAll
        
        
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.filterEvents(location: self.selected_location, type: self.selected_type, source_type: self.selected_source_type, age: AppConstant.eAll, tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
            
                Indicator.sharedInstance.hideIndicator()
                self.listContainerView.reloadData()
          
        })
    }
    @IBAction func videoSelectTapped(_ sender: Any) {
        
        videoSelectBtn.backgroundColor = default_green_color
        videoSelectBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        imageSelectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageSelectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        allSectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        allSectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        DataManager.isShowingFilterResult = true
        self.selected_source_type = AppConstant.eVideo
        Indicator.sharedInstance.showIndicator()
        
        UserVM.shared.filterEvents(location: self.selected_location, type: self.selected_type, source_type: self.selected_source_type, age: AppConstant.eAll, tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
            
                Indicator.sharedInstance.hideIndicator()
                self.listContainerView.reloadData()
          
        })
    }
    @IBAction func imageSelectTapped(_ sender: Any) {
        
        imageSelectBtn.backgroundColor = default_green_color
        imageSelectBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        allSectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        allSectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        videoSelectBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        videoSelectBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        DataManager.isShowingFilterResult = true
        self.selected_source_type = AppConstant.eImage
        
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.filterEvents(location: self.selected_location, type: self.selected_type, source_type: self.selected_source_type, age: AppConstant.eAll, tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
            
                Indicator.sharedInstance.hideIndicator()
                self.listContainerView.reloadData()
          
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabview.addSubview(self.segmentedView)
        segmentedView.listContainer = listContainerView
        contentview.addSubview(listContainerView)
        
        customNavBar.frame.size.height = navbarHeight
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 40)
        listContainerView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: self.contentview.frame.size.height)
    }
    @IBAction func postsearch(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "searchTypeVC") as! searchTypeVC
        VC.delegate = self
        present(VC, animated: true)
    }
    
    @IBAction func createpost(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "createpostVC") as! createpostVC
        navigationController?.pushViewController(VC, animated: true)
    }
    


}
extension postVC: SearchTypeDelegate{
    func selectSearchType(index: Int, type: String) {
        
        self.selected_location = type
        DataManager.isShowingFilterResult = true
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.filterEvents(location: type, type: self.selected_type, source_type: self.selected_source_type, age: AppConstant.eAll, tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
              
                Indicator.sharedInstance.hideIndicator()
                self.listContainerView.reloadData()
          
        })
        print(type)
    }
    
    
}


extension postVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
        self.selected_type = self.titles[index]
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.filterEvents(location: self.selected_location, type: self.selected_type, source_type: self.selected_source_type, age: AppConstant.eAll, tall: AppConstant.eAll, style: AppConstant.eAll, job: AppConstant.eAll, nick_name: AppConstant.eAll, completion: {_ in
            
                Indicator.sharedInstance.hideIndicator()
                self.listContainerView.reloadData()
          
        })
        
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            
            dotDataSource.dotStates[index] = false
            
            segmentedView.reloadItem(at: index)
            
        }
        for indicaotr in (segmentedView.indicators as! [JXSegmentedIndicatorBaseView]) {

               indicaotr.indicatorColor = default_green_color

        }
       
       navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
       segmentedView.reloadDataWithoutListContainer()
       

    }
    
    
}

extension postVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "contentforpostVC") as! contentforpostVC
        controller.height_table = Int(self.contentview.frame.size.height)
        print("________here____\(self.contentview.frame.size.height)")
        controller.pageType = index
        return controller
    }
  
}

extension postVC: SearchPostDelegate {
    func searchBtnTapped(data: Bool) {
        self.segmentedView.reloadData()
        self.listContainerView.reloadData()
       
    }
    
    
}
