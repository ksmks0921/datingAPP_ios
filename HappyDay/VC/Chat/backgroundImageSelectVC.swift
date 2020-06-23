//
//  backgroundImageSelectVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/20/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class backgroundImageSelectVC: UIViewController {

    @IBOutlet weak var imageCollection: UICollectionView!
    var images = ["back1", "back2", "back3", "back4", "back5", "back6", "back7", "back8", "back9", "back10", "back11", "back12"]
    var delegate: ImageSelectProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "backgroundImageCell", bundle: nil)
        imageCollection.register(nibCell, forCellWithReuseIdentifier: "backgroundImageCell")
        
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
    @IBAction func backBtnTapped(_ sender: Any) {
          self.navigationController?.popViewController(animated: true)
    }

}
extension backgroundImageSelectVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "backgroundImageCell", for: indexPath) as! backgroundImageCell
        cell.backgroundImageView.image = UIImage(named: images[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        self.delegate.SelectBackgroundImage(data: images[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            return CGSize(width: self.imageCollection.frame.size.width/2 - 16, height: (self.imageCollection.frame.size.height - 8)/3)
      

    }
    
}
