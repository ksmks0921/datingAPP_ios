//
//  customTabBarVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class customTabBarVC: UITabBarController {
    
    var tabItem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
        let deselectedImage_1 = UIImage(named: "sharp_search_black_18dp")?.withRenderingMode(.alwaysTemplate)
        let selectedImage_1 = UIImage(named: "sharp_search_black_18dp")?.withRenderingMode(.alwaysTemplate)
        
        tabItem = self.tabBar.items![0]
        tabItem.image = deselectedImage_1
        tabItem.selectedImage = selectedImage_1
        
        let deselectedImage_2 = UIImage(named: "sharp_menu_black_18dp")?.withRenderingMode(.alwaysTemplate)
        let selectedImage_2 = UIImage(named: "sharp_menu_black_18dp")?.withRenderingMode(.alwaysTemplate)
        
        tabItem = self.tabBar.items![1]
        tabItem.image = deselectedImage_2
        tabItem.selectedImage = selectedImage_2
        
        let deselectedImage_3 = UIImage(named: "outline_textsms_black_18dp")?.withRenderingMode(.alwaysTemplate)
        let selectedImage_3 = UIImage(named: "outline_textsms_black_18dp")?.withRenderingMode(.alwaysTemplate)
        
        tabItem = self.tabBar.items![2]
        tabItem.image = deselectedImage_3
        tabItem.selectedImage = selectedImage_3
        
        let deselectedImage_4 = UIImage(named: "outline_account_circle_black_18dp")?.withRenderingMode(.alwaysTemplate)
        let selectedImage_4 = UIImage(named: "outline_account_circle_black_18dp")?.withRenderingMode(.alwaysTemplate)
        
        tabItem = self.tabBar.items![3]
        tabItem.image = deselectedImage_4
        tabItem.selectedImage = selectedImage_4
        
        
        let numberOfTabs = CGFloat((tabBar.items?.count)!)
        let tabBarSize = CGSize(width: tabBar.frame.width / numberOfTabs, height: tabBar.frame.height)
        
        let selectedColor   = UIColor.green
        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        
        self.selectedIndex = 0
        
        
    }
    


}
