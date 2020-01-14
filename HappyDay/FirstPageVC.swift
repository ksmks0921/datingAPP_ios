//
//  FirstPageVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/12/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class FirstPageVC: UIViewController {

    @IBOutlet weak var pageCollection: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    var timer = Timer()
    var counter = 0
    
    var imgArr = [ UIImage(named: "first"),
                   UIImage(named: "second"),
                   UIImage(named: "third")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
       
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }

        // Do any additional setup after loading the view.
    }
    @objc func changeImage(){
        if counter < imgArr.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.pageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1

        }
        else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.pageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func gotoLogin(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
        navigationController?.pushViewController(VC, animated: true)
//        self.present(VC, animated: true, completion: nil)
    }
    @IBAction func gotoSignUp(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func facebookLogin(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "facebookLoginVC") as! facebookLoginVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
  

}
extension FirstPageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? firstCollectionCell
                //        if let vc = cell.viewWithTag(111) as? UIImageView{
                //            vc.image = imgArr[indexPath.row]
                //        }
                //        else if let ab = cell.viewWithTag(222) as? UIPageControl{
                //            ab.currentPage = indexPath.row
                //        }
                        cell?.img.image = imgArr[indexPath.row]
                        return cell!
    }
    
    
    
}
extension FirstPageVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = pageCollection.frame.size
//        let size = UIScreen.main.bounds
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
