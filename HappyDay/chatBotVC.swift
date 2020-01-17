//
//  chatBotVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView
class chatBotVC: UIViewController {
    
    var totalItemWidth: CGFloat = 0
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.hidesBarsOnTap = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        
        

        

        totalItemWidth = UIScreen.main.bounds.size.width - 30*2
        let titles = ["모두", "읽지 않음", "미 회선", "회신 된", "저장 된"]
        let titleDataSource = JXSegmentedTitleDataSource()
        titleDataSource.itemContentWidth = totalItemWidth/CGFloat(titles.count)
        titleDataSource.titles = titles
        titleDataSource.isTitleMaskEnabled = true
        titleDataSource.titleNormalColor = UIColor.gray
        titleDataSource.titleSelectedColor = UIColor.white
        titleDataSource.itemSpacing = 0
        segmentedDataSource = titleDataSource

        let gridView = UIView()
        gridView.frame = CGRect(x: 0, y: 0, width: totalItemWidth, height: 30)
        gridView.backgroundColor = UIColor.white
        gridView.layer.masksToBounds = true
        gridView.layer.cornerRadius = 3
        gridView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        
        gridView.layer.borderWidth = 1/UIScreen.main.scale
        let itemWidth = totalItemWidth/CGFloat(titles.count)
        for index in 0..<(titles.count - 1) {
            let line = UIView()
            line.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            line.frame = CGRect(x: CGFloat(index)*itemWidth - 1, y: 0, width: 1/UIScreen.main.scale, height: 30)
            gridView.addSubview(line)
        }

        segmentedView.dataSource = titleDataSource
        segmentedView.collectionView.backgroundView = gridView

        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 30
        indicator.indicatorCornerRadius = 3
        indicator.backgroundWidthIncrement = 2
        indicator.indicatorColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        segmentedView.indicators = [indicator]
        
        
        view.backgroundColor = .white

        
        segmentedView.delegate = self
        view.addSubview(self.segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)

    }
    

      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()

          segmentedView.frame = CGRect(x: 30, y: topbarHeight + 10, width: totalItemWidth, height: 30)
//          segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 30)
        
          listContainerView.frame = CGRect(x: 0, y: topbarHeight + 50, width: view.bounds.size.width, height: view.bounds.size.height  - topbarHeight - 50)
      }
    
      override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
               navigationController?.setNavigationBarHidden(false, animated: animated)
               
        }
        
    //       override func viewWillDisappear(_ animated: Bool) {
    //           super.viewWillDisappear(animated)
    //           navigationController?.setNavigationBarHidden(false, animated: animated)
    //       }
        
}

extension chatBotVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension chatBotVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "chatListVC") as! chatListVC
   
        return controller
    }
}
