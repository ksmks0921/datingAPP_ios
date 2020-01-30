//
//  chatListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class chatListVC: UIViewController {

   
    var partners = [message]()
    @IBOutlet weak var chatListTableView: UITableView!
    
    var friends = [person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

         let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
         self.chatListTableView.register(nib, forCellReuseIdentifier: "chatTableCell")
         chatListTableView.reloadData()
        
        
        
        
        let friend_1 = person(id : 1, name: "카트리나", avatar: "katrina_1", photos: 1, birthday: "16/05/1983", about_gender: "30대 후반", live_place: "홍콩", aboutMe: "힌디어 영화에서 일하는 영국 여배우. 그녀의 연기력에 대한 비평가들로부터 혼합 된 리뷰를 받았음에도 불구하고, 그녀는 볼리우드에서 자신을 설립했으며 인도에서 가장 보수가 많은 여배우 중 한 명입니다.", gender: "녀성", age: "35세", nickName: "얼음공주", job: "모델")
        friends.append(friend_1)
        let friend_2 = person(id : 2, name: "딜라바", avatar: "Dilraba_1", photos: 2, birthday: "03/06/1992", about_gender: "20대 후반", live_place: "딜리레바", aboutMe: "중국 배우, 모델 및 가수입니다. 그녀는 위구르족 출신이다.", gender: "녀성", age: "25세", nickName: "기녀", job: "모델, 가수")
        friends.append(friend_2)
        let friend_3 = person(id : 3, name: "타만나", avatar: "tamanna_1", photos: 3, birthday: "21/12/1989", about_gender: "30대 전반", live_place: "뭄바이", aboutMe: "전문적으로 타마 나아 (Tamannaah)라고 알려진 인도의 여배우는 주로 타밀어와 텔루구어 영화에 출연한다. 그녀는 여러 힌디어 영화에도 출연했다. 연기 외에도 그녀는 무대 쇼에 참여하며 브랜드 및 제품의 저명한 유명인입니다.", gender: "녀성", age: "35세", nickName: "따영", job: "모델, 배우")
        friends.append(friend_3)
        let friend_4 = person(id : 4, name: "빙빙", avatar: "Bingbing_1", photos: 4, birthday: "16/09/1981", about_gender: "30대 후반", live_place: "청도", aboutMe: " 중국 배우, 모델, TV 프로듀서 및 가수입니다. 2013 년부터 Fan은 2006 년 이후 매년 상위 10 위에 오른 이후 포브 차이나 셀러브리티 100 (Forbes China Celebrity 100)에서 4 년 연속 가장 높은 유명인으로 선정되었습니다.그녀는 세계에서 가장 보수가 많은 여배우 중 한 명이며 레드 카펫, 영화 시사회 및 패션쇼에서 자주 출연하기 때문에 글로벌 패션 아이콘이라고 불렀습니다.", gender: "녀성", age: "40세", nickName: "배뚱이", job: "모델, 배우, 프로듀서,  가수")
        friends.append(friend_4)
        
        
        let person_1 = message(friend_id: 1, name: friends[0].name!, photo: friends[0].avatar!, age: friends[0].age!, job: "모델", time: "21:21/02/01/2020", last_message: "뭐하니?", is_favorite: true, has_new: true, is_online: "online")
        partners.append(person_1)
        let person_2 = message(friend_id: 2, name: friends[1].name!, photo: friends[1].avatar!, age: friends[1].age!, job: friends[1].job!, time: "23:12/02/01/2020", last_message: "잘지내니?", is_favorite: true, has_new: false, is_online: "online")
        partners.append(person_2)
        let person_3 = message(friend_id: 3, name: friends[2].name!, photo: friends[2].avatar!, age: friends[2].age!, job: friends[2].job!, time: "08:12/02/01/2020",  last_message: "안녕?", is_favorite: false, has_new: false, is_online: "goaway")
        partners.append(person_3)
        let person_4 = message(friend_id: 4, name: friends[3].name!, photo: friends[3].avatar!, age: friends[3].age!, job: friends[3].job!, time: "12:29/02/01/2020",  last_message: "그렇게 하자.", is_favorite: false, has_new: true, is_online: "offline")
        partners.append(person_4)
        

    }
    

   

}

extension chatListVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return partners.count
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
             return CGSize(width: self.chatListTableView.frame.size.width, height: 100)
        

     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = chatListTableView.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
            let item = partners[indexPath.row]
            
            cell.name.text = item.name
          
            cell.photo.image = UIImage(named: item.photo ?? "avatar_woman" )
            cell.age.text = item.age
            cell.job.text = item.job
       
        
//            if item.is_favorite == true {
//                cell.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            }
//            else {
//                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            }
            if item.is_online == "online" {
                cell.status_icon.image = UIImage(named: "circle-24-green")
                cell.status.text = "온라인"
            }
            else if item.is_online == "offline"{
                cell.status_icon.image = UIImage(named: "circle-24-red")
                cell.status.text = "오프라인"
            }
            else {
                cell.status_icon.image = UIImage(named: "circle-24-yellow")
                cell.status.text = "자리비움"
            }
          
            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(AdvancedExampleViewController(), animated: true)
//        print("sdfsdf")
    }
}
