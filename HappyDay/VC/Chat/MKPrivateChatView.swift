


import UIKit
import MapKit
import MessageKit
import InputBarAccessoryView
import AVFoundation

class MKPrivateChatView: ChatViewController  , UITextViewDelegate {
    

    
    @IBOutlet weak var contentView: UIView!
    let outgoingAvatarOverlap: CGFloat = 0
    var chat_title: String!
    var background_image = UIImageView()
    private var isBlocker = false

    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        setupUI()
        setupNavigationButton()
        Indicator.sharedInstance.showIndicator()
        MessageVM.shared.geData(language: AppConstant.LanguageEnglish ,sender_id: chatId, connectedPerson: connectedPerson, completion: {_ in
             Indicator.sharedInstance.hideIndicator()
             self.loadFirstMessages()
        })
         
        messageInputBar.inputTextView.delegate = self as UITextViewDelegate
        messagesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CustomImageCell")
        
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
          self.title = chat_title
          self.navigationItem.rightBarButtonItems = [button_translate, button_setting]
          self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    func setupUI() {
        let height_of_view = self.messagesCollectionView.frame.size.height
        let width_of_view = self.messagesCollectionView.frame.size.width
        background_image.frame = CGRect(x: 0, y: 0, width: width_of_view, height: height_of_view)
        background_image.image = UIImage(named: "person_2")
        view.addSubview(background_image)
        messagesCollectionView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        messagesCollectionView.backgroundView = background_image
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
    
    @objc
    private func showSetting() {
        
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "backgroundImageSelectVC") as? backgroundImageSelectVC else { return }
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        MockSocket.shared.connect(with: [MessageVM.shared.wu])
//            .onTypingStatus { [weak self] in
//                self?.setTypingIndicatorViewHidden(false)
//            }.onNewMessage { [weak self] message in
//                self?.setTypingIndicatorViewHidden(true, performUpdates: {
//                    self?.insertMessage(message)
//                })
//        }
        
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "뒤로"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
        
    }
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
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
    
    func loadFirstMessages() {

           
           DispatchQueue.global(qos: .userInitiated).async {
               let count = UserDefaults.standard.mockMessagesCount()
               MessageVM.shared.getMessages(count: count) { messages in
                   DispatchQueue.main.async {
                       self.messageList = messages
                       self.messagesCollectionView.reloadData()
                       self.messagesCollectionView.scrollToBottom()
                   }
               }
           }
           
           
    }
    
//    override func loadMoreMessages() {
//        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
//            SampleData.shared.getAdvancedMessages(count: 20) { messages in
//                DispatchQueue.main.async {
//                    self.messageList.insert(contentsOf: messages, at: 0)
//                    self.messagesCollectionView.reloadDataAndKeepOffset()
//                    self.refreshControl.endRefreshing()
//                }
//            }
//        }
//    }
    
    override func configureMessageCollectionView() {
        super.configureMessageCollectionView()
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
        
        // Hide the outgoing avatar and adjust the label alignment to line up with the messages
        
        
        
//        layout?.setMessageOutgoingAvatarSize(.zero)
        layout?.setMessageOutgoingAvatarSize(CGSize(width: 36, height: 36))
        layout?.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: outgoingAvatarOverlap, right: 8)))
        layout?.setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
        layout?.setMessageOutgoingMessagePadding(UIEdgeInsets(top: -outgoingAvatarOverlap, left: 18, bottom: outgoingAvatarOverlap, right: -18))
        
        
        
        
        // Set outgoing avatar to overlap with the message bubble
        layout?.setMessageIncomingAvatarSize(CGSize(width: 36, height: 36))
        layout?.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: 18, bottom: outgoingAvatarOverlap, right: 0)))
       
        layout?.setMessageIncomingMessagePadding(UIEdgeInsets(top: -outgoingAvatarOverlap, left: -18, bottom: outgoingAvatarOverlap, right: 18))
        
//        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
//        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
//        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
//        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
//        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))

        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    override func configureMessageInputBar() {
        super.configureMessageInputBar()
        
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        messageInputBar.inputTextView.placeholder = "메쎄지를 입력하세요."
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        configureInputBarItems()
        
        
        let button = InputBarButtonItem()
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        button.image = UIImage(named: "icon_add")
        button.setSize(CGSize(width: 36, height: 36), animated: false)
        button.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        button.onKeyboardSwipeGesture { item, gesture in
            if (gesture.direction == .left)     { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 0, animated: true)        }
            if (gesture.direction == .right) { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 36, animated: true)    }
        }
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
        
        button.onTouchUpInside { item in
            self.actionAttachMessage()
        }
    }
    
    func actionAttachMessage() {

        messageInputBar.inputTextView.resignFirstResponder()
        
        let attributedString = NSAttributedString(string: "ション", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            
        ])
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let alertCamera = UIAlertAction(title: "ビデオ", style: .default) { action in
            ImagePicker.cameraMulti(target: self, edit: true)
        }
        let alertPhoto = UIAlertAction(title: "画像", style: .default) { action in
            ImagePicker.photoLibrary(target: self, edit: true)
        }
        let alertVideo = UIAlertAction(title: "ビデオ", style: .default) { action in
            ImagePicker.videoLibrary(target: self, edit: true)
        }
//        let alertAudio = UIAlertAction(title: "Audio", style: .default) { action in
////            self.actionAudio()
//        }
        let alertStickers = UIAlertAction(title: "ステッカー", style: .default) { action in
            self.actionStickers()
        }
//        let alertLocation = UIAlertAction(title: "Location", style: .default) { action in
////            self.actionLocation()
//        }

//        let configuration    = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
//        let imageCamera        = UIImage(systemName: "camera")
//        let imagePhoto        = UIImage(systemName: "photo")
//        let imageVideo        = UIImage(systemName: "play.rectangle")
////        let imageAudio        = UIImage(systemName: "music.mic")
//        let imageStickers    = UIImage(systemName: "tortoise")
//        let imageLocation    = UIImage(systemName: "location")
        let imageCamera        = UIImage(named: "rsz_icon_camera1")
        let imagePhoto        = UIImage(named: "rsz_icon_fileattach")
        let imageVideo        = UIImage(named: "youtube")
//        let imageAudio        = UIImage(systemName: "music.mic")
        let imageStickers    = UIImage(named: "smile")
        
        alertCamera.setValue(imageCamera, forKey: "image");     alert.addAction(alertCamera)
        alertPhoto.setValue(imagePhoto, forKey: "image");        alert.addAction(alertPhoto)
        alertVideo.setValue(imageVideo, forKey: "image");        alert.addAction(alertVideo)
//        alertAudio.setValue(imageAudio, forKey: "image");        alert.addAction(alertAudio)
        alertStickers.setValue(imageStickers, forKey: "image");    alert.addAction(alertStickers)
//        alertLocation.setValue(imageLocation, forKey: "image");    alert.addAction(alertLocation)
    
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        present(alert, animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          if(text == "\n") {
              textView.resignFirstResponder()
              return false
          }
          return true
    }
    
    func actionStickers() {

        let stickersView = StickersView()
        stickersView.delegate = self
        let navController = NavigationController(rootViewController: stickersView)
        present(navController, animated: true)
    }
    private func configureInputBarItems() {

        
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
//        messageInputBar.sendButton.imageView?.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.sendButton.setImage(UIImage(named: "icon_send"), for: .normal)
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
        messageInputBar.middleContentViewPadding.right = 2
        
        
        let charCountButton = InputBarButtonItem()
            .configure {
                $0.title = "0/140"
                $0.contentHorizontalAlignment = .right
                $0.setTitleColor(UIColor(white: 0.6, alpha: 1), for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
                $0.setSize(CGSize(width: 50, height: 25), animated: false)
            }.onTextViewDidChange { (item, textView) in
                item.title = "\(textView.text.count)/140"
                let isOverLimit = textView.text.count > 140
                item.inputBarAccessoryView?.shouldManageSendButtonEnabledState = !isOverLimit // Disable automated management when over limit
                if isOverLimit {
                    item.inputBarAccessoryView?.sendButton.isEnabled = false
                }
                let color = isOverLimit ? .red : UIColor(white: 0.6, alpha: 1)
                item.setTitleColor(color, for: .normal)
        }
        let bottomItems = [.flexibleSpace, charCountButton]
        messageInputBar.middleContentViewPadding.bottom = 8
        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)
        
     
        
        // This just adds some more flare
        messageInputBar.sendButton
            .onEnabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = .primaryColor
                })
            }.onDisabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
                })
        }
    }
    
    // MARK: - Helpers
    
    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool {
        return indexPath.section % 3 == 0 && !isPreviousMessageSameSender(at: indexPath)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messageList[indexPath.section].user == messageList[indexPath.section - 1].user
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messageList.count else { return false }
        return messageList[indexPath.section].user == messageList[indexPath.section + 1].user
    }
    
    func setTypingIndicatorViewHidden(_ isHidden: Bool, performUpdates updates: (() -> Void)? = nil) {
//        updateTitleView(title: "김똘똘", subtitle: isHidden ? "2 온라인" : "입력중...")
        setTypingIndicatorViewHidden(isHidden, animated: true, whilePerforming: updates) { [weak self] success in
            if success, self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    private func makeButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
            .configure {
                $0.spacing = .fixed(10)
                $0.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
                $0.setSize(CGSize(width: 25, height: 25), animated: false)
                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            }.onSelected {
                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            }.onDeselected {
                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            }.onTouchUpInside {
                print("Item Tapped")
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                actionSheet.addAction(action)
                if let popoverPresentationController = actionSheet.popoverPresentationController {
                    popoverPresentationController.sourceView = $0
                    popoverPresentationController.sourceRect = $0.frame
                }
                self.navigationController?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }

        // Very important to check this when overriding `cellForItemAt`
        // Super method will handle returning the typing indicator cell
        guard !isSectionReservedForTypingIndicator(indexPath.section) else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .custom = message.kind {
         
            let cell = messagesCollectionView.dequeueReusableCell(CustomCell.self, for: indexPath)
            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
            return cell
        }
        if case .photo = message.kind {
           
//             let cell = messagesCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomImageCell", for: indexPath)
            let cell = messagesCollectionView.dequeueReusableCell(MediaMessageCell.self, for: indexPath)
   //        cell.imageView.sd_setImage(with: message.url, placeholderImage: UIImage(named: "avatar_woman"))
            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
              return cell
        }
        if case .video = message.kind {
            
            let cell = messagesCollectionView.dequeueReusableCell(MediaMessageCell.self, for: indexPath)
   //        cell.imageView.sd_setImage(with: message.url, placeholderImage: UIImage(named: "avatar_woman"))
            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
              return cell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }

    // MARK: - MessagesDataSource

    override func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if isTimeLabelVisible(at: indexPath) {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    override func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if !isPreviousMessageSameSender(at: indexPath) {
            let name = message.sender.displayName
            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
        }
        return nil
    }

    override func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {

        if !isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message) {
            return NSAttributedString(string: "送信され", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
        }
        return nil
    }

}

// MARK: - MessagesDisplayDelegate

extension MKPrivateChatView: MessagesDisplayDelegate {

    // MARK: - Text Messages

    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }

    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        switch detector {
        case .hashtag, .mention:
            if isFromCurrentSender(message: message) {
                return [.foregroundColor: UIColor.white]
            } else {
                return [.foregroundColor: UIColor.primaryColor]
            }
        default: return MessageLabel.defaultAttributes
        }
    }

    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation, .mention, .hashtag]
    }

    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.kind {
        case .photo:
            return isFromCurrentSender(message: message) ? .clearColor : .clearColor
        default:
            return isFromCurrentSender(message: message) ? .primaryColor : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        

    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        var corners: UIRectCorner = []
        
        if isFromCurrentSender(message: message) {
            corners.formUnion(.topLeft)
            corners.formUnion(.bottomLeft)
//            if !isPreviousMessageSameSender(at: indexPath) {
//                corners.formUnion(.topRight)
//            }
//            if !isNextMessageSameSender(at: indexPath) {
//                corners.formUnion(.bottomRight)
//            }
        } else {
            corners.formUnion(.topRight)
            corners.formUnion(.bottomRight)
//            if !isPreviousMessageSameSender(at: indexPath) {
//                corners.formUnion(.topLeft)
//            }
//            if !isNextMessageSameSender(at: indexPath) {
//                corners.formUnion(.bottomLeft)
//            }
        }
        
        return .custom { view in
            let radius: CGFloat = 16
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
       if isFromCurrentSender(message: message) {
            avatarView.sd_setImage(with: URL(string: UserVM.current_user.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
            avatarView.layer.borderColor = UIColor.primaryColor.cgColor
        }
       else {
             avatarView.sd_setImage(with: URL(string: connectedPerson.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
            avatarView.layer.borderColor = (UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1) as! CGColor)
        
        }
        
//        let avatar = MessageVM.shared.getAvatarFor(sender: message.sender)
        
      
        
//        avatarView.set(avatar: avatar)
//        avatarView.isHidden = isNextMessageSameSender(at: indexPath)
        avatarView.layer.borderWidth = 2
        
        
    }
    
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // Cells are reused, so only add a button here once. For real use you would need to
        // ensure any subviews are removed if not needed
        accessoryView.subviews.forEach { $0.removeFromSuperview() }
        accessoryView.backgroundColor = .clear

        let shouldShow = Int.random(in: 0...10) == 0
        guard shouldShow else { return }

        let button = UIButton(type: .infoLight)
        button.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        accessoryView.addSubview(button)
        button.frame = accessoryView.bounds
        button.isUserInteractionEnabled = false // respond to accessoryView tap through `MessageCellDelegate`
        accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
        
        accessoryView.backgroundColor = UIColor.primaryColor.withAlphaComponent(0.3)
//         accessoryView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    // MARK: - Location Messages
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "ic_map_marker")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(2, 2, 2)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
        
        return LocationMessageSnapshotOptions(showsBuildings: true, showsPointsOfInterest: true, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }

    // MARK: - Audio Messages

    func audioTintColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return self.isFromCurrentSender(message: message) ? .white : .primaryColor
    }

    func configureAudioCell(_ cell: AudioMessageCell, message: MessageType) {
        audioController.configureAudioCell(cell, message: message) // this is needed especily when the cell is reconfigure while is playing sound
    }
    
}

// MARK: - MessagesLayoutDelegate

extension MKPrivateChatView: MessagesLayoutDelegate {

    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if isTimeLabelVisible(at: indexPath) {
            return 18
        }
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if isFromCurrentSender(message: message) {
            
            return  0
        } else {
            return  0
//            return !isPreviousMessageSameSender(at: indexPath) ? (20 + outgoingAvatarOverlap) : 0
        }
        
        
    }

    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return (!isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message)) ? 16 : 0
        return 0
    }

}



extension MKPrivateChatView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        let video = info[.mediaURL] as? URL
        let photo = info[.editedImage] as? UIImage

        messageSend(text: nil, photo: photo, sticker: nil, video: video, audio: nil)

        picker.dismiss(animated: true)
    }
    
    func messageSend(text: String?, photo: UIImage?, sticker: String?, video: URL?, audio: String?) {
       
        self.send(chatId: chatId, text: text, photo: photo, video: video, audio: audio, sticker: sticker)
    }
}
extension MKPrivateChatView: StickersDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func didSelectSticker(sticker: String) {
      
        messageSend(text: nil, photo: nil, sticker: sticker, video: nil, audio: nil)
//        messageSend(text: nil, photo: sticker, video: nil, audio: nil)
    }
    
}
extension MKPrivateChatView: SearchTypeDelegate{
    
    func selectSearchType(index: Int, type: String) {
        
        if type == AppConstant.languages[0] {
            
            DispatchQueue.global(qos: .userInitiated).async {
//                let count = UserDefaults.standard.mockMessagesCount()
                MessageVM.shared.changeLanguage(language: AppConstant.LanguageKorean) { messages in
                    DispatchQueue.main.async {
                        self.messageList = messages
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                    }
                }
            }
            
        }
        else if type == AppConstant.languages[1] {
            DispatchQueue.global(qos: .userInitiated).async {
                MessageVM.shared.changeLanguage(language: AppConstant.LanguageChinese) { messages in
                    DispatchQueue.main.async {
                        self.messageList = messages
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                    }
                }
            }
        }
        else if type == AppConstant.languages[2] {
             DispatchQueue.global(qos: .userInitiated).async {
                           MessageVM.shared.changeLanguage(language: AppConstant.LanguageJapanese) { messages in
                               DispatchQueue.main.async {
                                   self.messageList = messages
                                   self.messagesCollectionView.reloadData()
                                   self.messagesCollectionView.scrollToBottom()
                               }
                           }
                       }
        }
        else {
             DispatchQueue.global(qos: .userInitiated).async {
               MessageVM.shared.changeLanguage(language: AppConstant.LanguageEnglish) { messages in
                   DispatchQueue.main.async {
                       self.messageList = messages
                       self.messagesCollectionView.reloadData()
                       self.messagesCollectionView.scrollToBottom()
                   }
               }
             }
        }
        
    }
    
    
}
extension MKPrivateChatView {
    
    func send(chatId: String, text: String?, photo: UIImage?, video: URL?, audio: String?, sticker: String?) {
        
        if UserVM.current_user.user_sex == "녀자" || UserVM.user_points > 20{
                 print("______sending image_________")
                   let formatter = DateFormatter()
                   formatter.locale = Locale(identifier: "en_US_POSIX")
                   formatter.dateFormat = "h:mm a"
                   formatter.amSymbol = "AM"
                   formatter.pmSymbol = "PM"

                   let time_string = formatter.string(from: Date())

                   let calendar = Calendar.current

                   let month_string = calendar.component(.month, from: Date())
                   let date_string = calendar.component(.day, from: Date())
                   let date = String(month_string) + "월 " +  String(date_string) + "일"
           
                   Indicator.sharedInstance.showIndicator()
                   if photo != nil {
                    UserVM.shared.sendImageMessage(sender_id: chatId, receiver_id: connectedPerson.user_id!, text: "", sourceType: AppConstant.eImage, sourcePath: "", thumb_path: "", time: time_string, date: date,imageData: photo!, completion: {_ in
                           Indicator.sharedInstance.hideIndicator()
                           self.messageInputBar.sendButton.stopAnimating()
                           self.messageInputBar.inputTextView.placeholder = "メールを入力してください."

                           self.messagesCollectionView.scrollToBottom(animated: true)

                       })
                   }
                   if video != nil {
                    SettingVM.shared.getThumbnailImageFromVideoUrl(url: video!) { (thumbImage) in
                        let video_thumbImage = thumbImage
                        UserVM.shared.sendVideoMessage(sender_id: chatId, receiver_id: self.connectedPerson.user_id!, text: "", sourceType: AppConstant.eVideo, sourcePath: "", thumb_path: "", time: time_string, date: date, thumb_imageData:video_thumbImage!,  video: video!, completion: {_ in
                                Indicator.sharedInstance.hideIndicator()
                                self.messageInputBar.sendButton.stopAnimating()
                                self.messageInputBar.inputTextView.placeholder = "メールを入力してください."

                                self.messagesCollectionView.scrollToBottom(animated: true)

                            })
                        }
                    }
                    if sticker != nil {
                        UserVM.shared.sendEmojMessage(sender_id: chatId, receiver_id: connectedPerson.user_id!, sourceType: AppConstant.eEmoji, sourcePath: sticker!, time: time_string, date: date, completion: {_ in
                            Indicator.sharedInstance.hideIndicator()
                            self.messageInputBar.sendButton.stopAnimating()
                            self.messageInputBar.inputTextView.placeholder = "メールを入力してください."

                            self.messagesCollectionView.scrollToBottom(animated: true)

                        })
                        
                    }
                    
                  
        }
        else {
            print("______not sending image_________")
            self.showAlertPoints(message: "ポイントが足りないのでメールを送信できません", title: "通知", otherButtons: ["確認": {(action) in
            
                  print("_______")
            }], cancelTitle: "キャンセル", cancelAction: { (Acrion) in
                  print("cancel clicked____")
            })
        }
        
        
        
                
                
                
      

    }
//    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
//        DispatchQueue.global().async { //1
//            let asset = AVAsset(url: url) //2
//            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
//            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
//            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
//            do {
//                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
//                let thumbImage = UIImage(cgImage: cgThumbImage) //7
//                DispatchQueue.main.async { //8
//                    completion(thumbImage) //9
//                }
//            } catch {
//                print(error.localizedDescription) //10
//                DispatchQueue.main.async {
//                    completion(nil) //11
//                }
//            }
//        }
//    }
    
    
}
extension MKPrivateChatView : ImageSelectProtocol{
    func SelectBackgroundImage(data: String) {
        self.background_image.image = UIImage(named: data)
        print(data)
    }
    
    
}
extension MKPrivateChatView {
    func showAlertPoints(message: String?, title:String = "通知", otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String = "キャンセル", cancelAction: ((UIAlertAction)-> ())? = nil) {
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
