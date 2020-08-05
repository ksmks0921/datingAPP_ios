
/*
MIT License

Copyright (c) 2017-2019 MessageKit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit
import MessageKit
import InputBarAccessoryView
import Lightbox

protocol ImageSelectProtocol
{
    func SelectBackgroundImage(data: String)
    
}
/// A base class for the example controllers
class ChatViewController: MessagesViewController, MessagesDataSource, LightboxControllerPageDelegate ,LightboxControllerDismissalDelegate, UITextViewDelegate  {
    
    
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print("ok")
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        print("ok")
    }
    
    
 
    
    /// The `BasicAudioController` controll the AVAudioPlayer state (play, pause, stop) and udpate audio cell UI accordingly.
    open lazy var audioController = BasicAudioController(messageCollectionView: messagesCollectionView)

    var messageList: [MockMessage] = []
    var background_image = UIImageView()
    var chatId = ""
    var connectedPerson: person!
     
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMessageCollectionView()
        configureMessageInputBar()
        setupUI()
        setupNavigationButton()
        loadFirstMessages()
        
       
    }
    func setupUI() {
        let height_of_view = self.messagesCollectionView.frame.size.height
        let width_of_view = self.messagesCollectionView.frame.size.width
        background_image.frame = CGRect(x: 0, y: 0, width: width_of_view, height: height_of_view)
        background_image.image = UIImage(named: "person_2")
        view.addSubview(background_image)
        messagesCollectionView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        messagesCollectionView.backgroundView = background_image
        messageInputBar.inputTextView.delegate = self
        messagesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CustomImageCell")
    }
    @objc
    private func selectLanguage() {
      
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
        let items = AppConstant.languages
        
        let height_view = self.view.frame.size.height
        let height_bottom_view = (items.count + 1) * 60
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
        present(popupVC, animated: true, completion: nil)
        
    }
    func loadFirstMessages() {
       
      
            Indicator.sharedInstance.showIndicator()
            MessageVM.shared.geData(language: AppConstant.LanguageEnglish ,sender_id: self.chatId, connectedPerson: self.connectedPerson, completion: {_ in
                    let count = UserDefaults.standard.mockMessagesCount()
                    MessageVM.shared.getMessages(count: count) { messages in
                        Indicator.sharedInstance.hideIndicator()
                        
                        self.messageList = messages
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                        
                    }
             })
               
        
           
           
    }
    @objc
    private func showSetting() {
        
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "backgroundImageSelectVC") as? backgroundImageSelectVC else { return }
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    func setupNavigationButton() {
        
         let button_translate = UIBarButtonItem(
              image: UIImage(named: "translate_icon"),
              style: .plain,
              target: self,
              
              action: #selector(selectLanguage)
          )
          let button_setting = UIBarButtonItem(
              image: UIImage(named: "rsz_icon_setting_white"),
              style: .plain,
              target: self,
              action: #selector(showSetting)
          )
       
          button_setting.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          button_translate.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//          self.title = chat_title
          self.navigationItem.rightBarButtonItems = [button_translate, button_setting]
          self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        MockSocket.shared.connect(with: [SampleData.shared.nathan, SampleData.shared.wu])
//            .onNewMessage { [weak self] message in
//                self?.insertMessage(message)
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
        audioController.stopAnyOngoingPlaying()
    }
    
  
    
    @objc
    func loadMoreMessages() {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
            MessageVM.shared.getMessages(count: 20) { messages in
                DispatchQueue.main.async {
                    self.messageList.insert(contentsOf: messages, at: 0)
                    self.messagesCollectionView.reloadDataAndKeepOffset()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
        messageInputBar.sendButton.setTitleColor(
            UIColor.primaryColor.withAlphaComponent(0.3),
            for: .highlighted
        )
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: MockMessage) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    // MARK: - MessagesDataSource
    
    func currentSender() -> SenderType {
        return MessageVM.shared.currentSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(string: "Read", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! profileVC
        VC.person = self.connectedPerson
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
//        guard let indexPath = messagesCollectionView.indexPath(for: cell),
//            let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath, in: messagesCollectionView) else {
//                print("Failed to identify message when audio cell receive tap gesture")
//                return
//        }
////        let indexPath = messagesCollectionView.indexPath(for: cell)
////        let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath!, in: messagesCollectionView)
//        if case .custom = message.kind {
//
//        }
//        if case .photo = message.kind {
//            let images = [LightboxImage(imageURL: URL(string: MessageVM.shared.custom_messages[indexPath.row].source_path!)!)]
//            let controller = LightboxController(images: images)
//            controller.pageDelegate = self
//            controller.dismissalDelegate = self
//            controller.dynamicBackground = true
//            LightboxConfig.CloseButton.image = UIImage(named: "icon_close1")
//            LightboxConfig.CloseButton.text = ""
//            present(controller, animated: true, completion: nil)
//        }
//        if case .video = message.kind {
//
//            print("____\(MessageVM.shared.custom_messages[indexPath.row].thumb_path)")
//            print("__\(indexPath.row)")
//
//            let url = URL(string:MessageVM.shared.custom_messages[indexPath.row].thumb_path!)
//                if let data = try? Data(contentsOf: url!)
//                {
//                    let video_url : String = MessageVM.shared.custom_messages[indexPath.row].source_path!
//                 let image: UIImage = UIImage(data: data)!
//                     let video = [LightboxImage(
//                       image: image,
//                       text: "",
//                       videoURL: URL(string: video_url)
//                     )]
//                     let controller = LightboxController(images: video)
//                     controller.pageDelegate = self
//                     controller.dismissalDelegate = self
//                     controller.dynamicBackground = true
//                     LightboxConfig.CloseButton.image = UIImage(named: "icon_close1")
//                     LightboxConfig.CloseButton.text = ""
//                     present(controller, animated: true, completion: nil)
//                }
//        }
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapCellBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }

    func didTapPlayButton(in cell: AudioMessageCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell),
            let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath, in: messagesCollectionView) else {
                print("Failed to identify message when audio cell receive tap gesture")
                return
        }
        guard audioController.state != .stopped else {
            // There is no audio sound playing - prepare to start playing for given audio message
            audioController.playSound(for: message, in: cell)
            return
        }
        if audioController.playingMessage?.messageId == message.messageId {
            // tap occur in the current cell that is playing audio sound
            if audioController.state == .playing {
                audioController.pauseSound(for: message, in: cell)
            } else {
                audioController.resumeSound()
            }
        } else {
            // tap occur in a difference cell that the one is currently playing sound. First stop currently playing and start the sound for given message
            audioController.stopAnyOngoingPlaying()
            audioController.playSound(for: message, in: cell)
        }
    }

    func didStartAudio(in cell: AudioMessageCell) {
        print("Did start playing audio sound")
    }

    func didPauseAudio(in cell: AudioMessageCell) {
        print("Did pause audio sound")
    }

    func didStopAudio(in cell: AudioMessageCell) {
        print("Did stop audio sound")
    }

    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }

}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }

    func didSelectHashtag(_ hashtag: String) {
        print("Hashtag selected: \(hashtag)")
    }

    func didSelectMention(_ mention: String) {
        print("Mention selected: \(mention)")
    }

    func didSelectCustom(_ pattern: String, match: String?) {
        print("Custom data detector patter selected: \(pattern)")
    }

}

// MARK: - MessageInputBarDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

        let components = inputBar.inputTextView.components

        if UserVM.current_user.user_sex == "女性" {
            sendMessage()
        }
        else {
            if UserVM.user_points < 20 {
                
                self.showAlert(message: "ポイントが足りないのでメールを送信できません", title: "通知", otherButtons: ["確認": {(action) in
                
                      print("_______")
                }], cancelTitle: "キャンセル", cancelAction: { (Acrion) in
                    print("cancel clicked____")
                })
            }
            else {
                sendMessage()
            }
        }
        
        
        
            
    }
        
    func sendMessage() {
        // Here we can parse for which substrings were autocompleted
        let attributedText = messageInputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }

        
        let message_content  = messageInputBar.inputTextView.text
        messageInputBar.inputTextView.text = String()
        messageInputBar.invalidatePlugins()

        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "....."
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let time_string = formatter.string(from: Date())

       let calendar = Calendar.current

       let month_string = calendar.component(.month, from: Date())
       let date_string = calendar.component(.day, from: Date())
       let date = String(month_string) + "月" +  String(date_string) + "日"
        UserVM.shared.sendMessage(sender_id: chatId, receiver_id: connectedPerson.user_id!, text: message_content!, sourceType: AppConstant.eText, sourcePath: "", thumb_path: "", time: time_string, date: date) { (success, message, error) in
               
               
                                  if error == nil{
                                   if success{
                                       let count = UserDefaults.standard.mockMessagesCount()
                                       MessageVM.shared.getMessages(count: count) { messages in
                                           Indicator.sharedInstance.hideIndicator()
                                          
                                               self.messageList = messages
                                            print(".....\(self.messageList.count)")
                                               self.messagesCollectionView.reloadData()
                                               self.messagesCollectionView.scrollToBottom()
                                               self.messageInputBar.sendButton.stopAnimating()
                                               self.messageInputBar.inputTextView.placeholder = "メールを入力してください"
                                               self.messagesCollectionView.scrollToBottom(animated: true)
                                           
                                       }
//                                       DispatchQueue.global(qos: .default).async {
//                                           // fake send request task
//                                           sleep(1)
//                                           DispatchQueue.main.async { [weak self] in
//                                               self?.messageInputBar.sendButton.stopAnimating()
//                                               self?.messageInputBar.inputTextView.placeholder = "メールを入力してください"
//                                               self?.messagesCollectionView.scrollToBottom(animated: true)
//                                           }
//                                       }
                                   }
                           }
               
                       }
               
        
           
    }
    
//    func showAlert(message: String?, title:String = "알림", otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String = "취소", cancelAction: ((UIAlertAction)-> ())? = nil) {
//        let newTitle = title.capitalized
//        let newMessage = message
//        let alert = UIAlertController(title: newTitle, message: newMessage, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction))
//        
//        if otherButtons != nil {
//            for key in otherButtons!.keys {
//                alert.addAction(UIAlertAction(title: key, style: .default, handler: otherButtons![key]))
//            }
//        }
//        present(alert, animated: true, completion: nil)
//    }

//    private func insertMessages(_ data: [Any]) {
//        for component in data {
//            let user = MessageVM.shared.currentSender
//            if let str = component as? String {
//                let message = MockMessage(text: str, user: user!, messageId: UUID().uuidString, date: Date())
//                insertMessage(message)
//            } else if let img = component as? UIImage {
////                let message = MockMessage(image: img, user: user!, messageId: UUID().uuidString, date: Date())
////                insertMessage(message)
//            }
//        }
//    }
}
extension ChatViewController {
    func showAlert(message: String?, title:String = "通知", otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String = "キャンセル", cancelAction: ((UIAlertAction)-> ())? = nil) {
        let newTitle = title.capitalized
        let newMessage = message
        let alert = UIAlertController(title: newTitle, message: newMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction))
        
        if otherButtons != nil {
            for key in otherButtons!.keys {
                alert.addAction(UIAlertAction(title: key, style: .default, handler: otherButtons![key]))
            }
        }
        present(alert, animated: true, completion: nil)
    }
}
extension ChatViewController: SearchTypeDelegate{
    
    func selectSearchType(index: Int, type: String) {
        
        if type == AppConstant.languages[2] {
            DataManager.language = AppConstant.LanguageKorean
            loadFirstMessages()
            
        }
        else if type == AppConstant.languages[3] {
            DataManager.language = AppConstant.LanguageChinese
            loadFirstMessages()
           
        }
        else if type == AppConstant.languages[1] {
            DataManager.language = AppConstant.LanguageJapanese
            loadFirstMessages()
//             DispatchQueue.global(qos: .userInitiated).async {
//                           MessageVM.shared.changeLanguage(language: AppConstant.LanguageJapanese) { messages in
//                               DispatchQueue.main.async {
//
//                                    self.messageList.removeAll()
//                                   self.messageList = messages
//                                   self.messagesCollectionView.reloadData()
//                                   self.messagesCollectionView.scrollToBottom()
//                               }
//                           }
//                       }
        }
        else {
             DataManager.language = AppConstant.LanguageEnglish
             loadFirstMessages()
             
        }
        
    }
    
    
}
extension ChatViewController : ImageSelectProtocol{
    func SelectBackgroundImage(data: String) {
        self.background_image.image = UIImage(named: data)
        print(data)
    }
    
    
}
