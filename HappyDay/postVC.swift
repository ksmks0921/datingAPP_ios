//
//  postVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView

class postVC: UIViewController {
    
    
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    @IBOutlet weak var tabview: UIView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var customNavBar: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        let titles = ["전체", "전국메일 친구", "친구 모집", "지금부터 놀자"]
        
        let tempdataSource = JXSegmentedTitleDataSource()
        tempdataSource.isTitleColorGradientEnabled = false
        tempdataSource.titles = titles
        tempdataSource.titleSelectedColor = UIColor.white
        segmentedDataSource = tempdataSource
        
    
        
     
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorHeight = 30
        indicator.indicatorWidthIncrement = 20
        indicator.indicatorColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
  
        
        segmentedView.indicators = [indicator]


         segmentedView.dataSource = segmentedDataSource
         segmentedView.delegate = self
         tabview.addSubview(self.segmentedView)

         segmentedView.listContainer = listContainerView
         contentview.addSubview(listContainerView)


    }
    private func setupNavigationBar(){
        let button_1 = UIButton(type: .system)
        button_1.setImage(UIImage(systemName: "doc.text.magnifyingglass"), for: .normal)
        button_1.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let button_2 = UIButton(type: .system)
        button_2.setImage(UIImage(systemName: "doc.text.magnifyingglass"), for: .normal)
        button_2.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button_1), UIBarButtonItem(customView: button_2)]
    }
    @objc func addTapped(){
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "searchTypeVC") as! searchTypeVC
                navigationController?.pushViewController(VC, animated: true)
    }
    @objc func playTapped(){
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "createpostVC") as! createpostVC
                    navigationController?.pushViewController(VC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customNavBar.frame.size.height = navbarHeight
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 30)
        
        listContainerView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height  - 50)
    }
    @IBAction func postsearch(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "searchTypeVC") as! searchTypeVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func createpost(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "createpostVC") as! createpostVC
        navigationController?.pushViewController(VC, animated: true)
    }
    


}
extension postVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
            
        }
        for indicaotr in (segmentedView.indicators as! [JXSegmentedIndicatorBaseView]) {
           
           if index == 0 {
               indicaotr.indicatorColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
           }
           else if index == 1 {
               indicaotr.indicatorColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
           }
           else if index == 2 {
               indicaotr.indicatorColor = #colorLiteral(red: 0.8823529412, green: 0.2274509804, blue: 0.2274509804, alpha: 1)
           }
        }
       segmentedView.reloadDataWithoutListContainer()
       navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
        if index == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "playnowVC") as! playnowVC
            navigationController?.pushViewController(VC, animated: true)
        }
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
        controller.pageType = index
        return controller
    }
}
