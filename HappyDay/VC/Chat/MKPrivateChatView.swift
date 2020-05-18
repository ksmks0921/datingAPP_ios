///*
// MIT License
//
// Copyright (c) 2017-2019 MessageKit
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// */
//
//import UIKit
//import MapKit
//import MessageKit
//import InputBarAccessoryView
//
//class MKPrivateChatView: ChatViewController {
//
//
//
//    @IBOutlet weak var contentView: UIView!
//    let outgoingAvatarOverlap: CGFloat = 17.5
//    var chat_title: String!
//
//    private var isBlocker = false
//
//
//
//
//    override func viewDidLoad() {
//
//
//        super.viewDidLoad()
//        let button_translate = UIBarButtonItem(
//               image: UIImage(named: "translate_icon"),
//               style: .plain,
//               target: self,
//
//               action: #selector(selectLanguage)
//           )
//
//           let button_setting = UIBarButtonItem(
//               image: UIImage(systemName: "gear"),
//               style: .plain,
//               target: self,
//               action: #selector(showSetting)
//           )
//           button_setting.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//           button_translate.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//           self.title = chat_title
//
//           self.navigationItem.rightBarButtonItems = [button_translate, button_setting]
//
//
//
//
//
//    }
//    @objc
//    private func selectLanguage() {
//
//    }
//
//    @objc
//    private func showSetting() {
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//          super.viewWillAppear(animated)
//          navigationController?.setNavigationBarHidden(false, animated: animated)
//          navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//          navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
//      }
//    @IBAction func backBtnTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
////    override func loadFirstMessages() {
////        DispatchQueue.global(qos: .userInitiated).async {
////            let count = UserDefaults.standard.mockMessagesCount()
////            MessageVM.shared.getAdvancedMessages(count: count) { messages in
////                DispatchQueue.main.async {
////                    self.messageList = messages
////                    self.messagesCollectionView.reloadData()
////                    self.messagesCollectionView.scrollToBottom()
////                }
////            }
////        }
////    }
//
////    override func loadMoreMessages() {
////        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
////            SampleData.shared.getAdvancedMessages(count: 20) { messages in
////                DispatchQueue.main.async {
////                    self.messageList.insert(contentsOf: messages, at: 0)
////                    self.messagesCollectionView.reloadDataAndKeepOffset()
////                    self.refreshControl.endRefreshing()
////                }
////            }
////        }
////    }
//
//    override func configureMessageCollectionView() {
//        super.configureMessageCollectionView()
//
//        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
//        layout?.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
//
//        // Hide the outgoing avatar and adjust the label alignment to line up with the messages
//        layout?.setMessageOutgoingAvatarSize(.zero)
//        layout?.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
//        layout?.setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
//
//        // Set outgoing avatar to overlap with the message bubble
//        layout?.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: 18, bottom: outgoingAvatarOverlap, right: 0)))
//        layout?.setMessageIncomingAvatarSize(CGSize(width: 30, height: 30))
//        layout?.setMessageIncomingMessagePadding(UIEdgeInsets(top: -outgoingAvatarOverlap, left: -18, bottom: outgoingAvatarOverlap, right: 18))
//
//        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
//        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
//        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
//        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
//        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
//
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//    }
//
//    override func configureMessageInputBar() {
//        super.configureMessageInputBar()
//
//        messageInputBar.isTranslucent = true
//        messageInputBar.separatorLine.isHidden = true
//        messageInputBar.inputTextView.tintColor = .primaryColor
//        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
//        messageInputBar.inputTextView.placeholder = "메쎄지를 입력하세요."
//        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
//        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 36)
//        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
//        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
//        messageInputBar.inputTextView.layer.borderWidth = 1.0
//        messageInputBar.inputTextView.layer.cornerRadius = 16.0
//        messageInputBar.inputTextView.layer.masksToBounds = true
//        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
//        configureInputBarItems()
//
//
//        let button = InputBarButtonItem()
//        button.image = UIImage(systemName: "plus.circle.fill")
//        button.setSize(CGSize(width: 42, height: 42), animated: false)
//        button.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        button.onKeyboardSwipeGesture { item, gesture in
//            if (gesture.direction == .left)     { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 0, animated: true)        }
//            if (gesture.direction == .right) { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 36, animated: true)    }
//        }
//        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
//
//        button.onTouchUpInside { item in
//            self.actionAttachMessage()
//        }
//    }
//
//    func actionAttachMessage() {
//
//        messageInputBar.inputTextView.resignFirstResponder()
//
//        let attributedString = NSAttributedString(string: "Title", attributes: [
//            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
//            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        ])
//
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        let alertCamera = UIAlertAction(title: "카메라", style: .default) { action in
//            ImagePicker.cameraMulti(target: self, edit: true)
//        }
//        let alertPhoto = UIAlertAction(title: "사진", style: .default) { action in
//            ImagePicker.photoLibrary(target: self, edit: true)
//        }
//        let alertVideo = UIAlertAction(title: "비디오", style: .default) { action in
//            ImagePicker.videoLibrary(target: self, edit: true)
//        }
////        let alertAudio = UIAlertAction(title: "Audio", style: .default) { action in
//////            self.actionAudio()
////        }
//        let alertStickers = UIAlertAction(title: "스틱커", style: .default) { action in
//            self.actionStickers()
//        }
////        let alertLocation = UIAlertAction(title: "Location", style: .default) { action in
//////            self.actionLocation()
////        }
//
//        let configuration    = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
//        let imageCamera        = UIImage(systemName: "camera", withConfiguration: configuration)
//        let imagePhoto        = UIImage(systemName: "photo", withConfiguration: configuration)
//        let imageVideo        = UIImage(systemName: "play.rectangle", withConfiguration: configuration)
//        let imageAudio        = UIImage(systemName: "music.mic", withConfiguration: configuration)
//        let imageStickers    = UIImage(systemName: "tortoise", withConfiguration: configuration)
//        let imageLocation    = UIImage(systemName: "location", withConfiguration: configuration)
//
//        alertCamera.setValue(imageCamera, forKey: "image");     alert.addAction(alertCamera)
//        alertPhoto.setValue(imagePhoto, forKey: "image");        alert.addAction(alertPhoto)
//        alertVideo.setValue(imageVideo, forKey: "image");        alert.addAction(alertVideo)
////        alertAudio.setValue(imageAudio, forKey: "image");        alert.addAction(alertAudio)
//        alertStickers.setValue(imageStickers, forKey: "image");    alert.addAction(alertStickers)
////        alertLocation.setValue(imageLocation, forKey: "image");    alert.addAction(alertLocation)
//
//        alert.addAction(UIAlertAction(title: "취 소", style: .cancel))
//        alert.setValue(attributedString, forKey: "attributedTitle")
//        present(alert, animated: true)
//    }
//
//    func actionStickers() {
//
//        let stickersView = StickersView()
//        stickersView.delegate = self
//        let navController = NavigationController(rootViewController: stickersView)
//        present(navController, animated: true)
//    }
//
//    private func configureInputBarItems() {
////        let view_1 = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
////        view_1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
////
////        let button_1 = UIButton(type: .system)
////        button_1.setImage(UIImage(named: "round_add_circle_black_18dp"), for: .normal)
////        button_1.frame = CGRect(x: 2, y: 2, width: 38, height: 38)
////        button_1.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
////
////        button_1.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
////        view_1.addSubview(button_1)
////
////        button_1.addTarget(self, action: Selector(("didButtonClick:")), for: .touchUpInside)
////
////        messageInputBar.leftStackView.addSubview(button_1)
////
////        let button_2 = UIButton(type: .system)
////        button_2.setImage(UIImage(named: "round_sentiment_satisfied_black_18dp"), for: .normal)
////        button_2.frame = CGRect(x: -42, y: 2, width: 36, height: 36)
////        button_2.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
////        button_2.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
////        messageInputBar.rightStackView.addSubview(button_2)
////
////        button_1.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
//////        button_2.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
//
//        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
//        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
////        messageInputBar.sendButton.imageView?.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
//        messageInputBar.sendButton.setImage(UIImage(named: "right-arrow"), for: .normal)
//        messageInputBar.sendButton.title = nil
//        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
//        messageInputBar.middleContentViewPadding.right = 2
//
//
//        let charCountButton = InputBarButtonItem()
//            .configure {
//                $0.title = "0/140"
//                $0.contentHorizontalAlignment = .right
//                $0.setTitleColor(UIColor(white: 0.6, alpha: 1), for: .normal)
//                $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
//                $0.setSize(CGSize(width: 50, height: 25), animated: false)
//            }.onTextViewDidChange { (item, textView) in
//                item.title = "\(textView.text.count)/140"
//                let isOverLimit = textView.text.count > 140
//                item.inputBarAccessoryView?.shouldManageSendButtonEnabledState = !isOverLimit // Disable automated management when over limit
//                if isOverLimit {
//                    item.inputBarAccessoryView?.sendButton.isEnabled = false
//                }
//                let color = isOverLimit ? .red : UIColor(white: 0.6, alpha: 1)
//                item.setTitleColor(color, for: .normal)
//        }
//        let bottomItems = [.flexibleSpace, charCountButton]
//        messageInputBar.middleContentViewPadding.bottom = 8
//        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)
//
//
//
//        // This just adds some more flare
//        messageInputBar.sendButton
//            .onEnabled { item in
//                UIView.animate(withDuration: 0.3, animations: {
//                    item.imageView?.backgroundColor = .primaryColor
//                })
//            }.onDisabled { item in
//                UIView.animate(withDuration: 0.3, animations: {
//                    item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
//                })
//        }
//
//
//    }
//
//    // MARK: - Helpers
//
//    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool {
//        return indexPath.section % 3 == 0 && !isPreviousMessageSameSender(at: indexPath)
//    }
//
//    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
//        guard indexPath.section - 1 >= 0 else { return false }
//        return messageList[indexPath.section].user == messageList[indexPath.section - 1].user
//    }
//
//    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
//        guard indexPath.section + 1 < messageList.count else { return false }
//        return messageList[indexPath.section].user == messageList[indexPath.section + 1].user
//    }
//
//    func setTypingIndicatorViewHidden(_ isHidden: Bool, performUpdates updates: (() -> Void)? = nil) {
//        updateTitleView(title: "김똘똘", subtitle: isHidden ? "2 온라인" : "입력중...")
//        setTypingIndicatorViewHidden(isHidden, animated: true, whilePerforming: updates) { [weak self] success in
//            if success, self?.isLastSectionVisible() == true {
//                self?.messagesCollectionView.scrollToBottom(animated: true)
//            }
//        }
//    }
//
//    private func makeButton(named: String) -> InputBarButtonItem {
//        return InputBarButtonItem()
//            .configure {
//                $0.spacing = .fixed(10)
//                $0.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
//                $0.setSize(CGSize(width: 25, height: 25), animated: false)
//                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//            }.onSelected {
//                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//            }.onDeselected {
//                $0.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//            }.onTouchUpInside {
//                print("Item Tapped")
//                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                actionSheet.addAction(action)
//                if let popoverPresentationController = actionSheet.popoverPresentationController {
//                    popoverPresentationController.sourceView = $0
//                    popoverPresentationController.sourceRect = $0.frame
//                }
//                self.navigationController?.present(actionSheet, animated: true, completion: nil)
//        }
//    }
//
//    // MARK: - UICollectionViewDataSource
//
//    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
//            fatalError("Ouch. nil data source for messages")
//        }
//
//        // Very important to check this when overriding `cellForItemAt`
//        // Super method will handle returning the typing indicator cell
//        guard !isSectionReservedForTypingIndicator(indexPath.section) else {
//            return super.collectionView(collectionView, cellForItemAt: indexPath)
//        }
//
//        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
//        if case .custom = message.kind {
//            let cell = messagesCollectionView.dequeueReusableCell(CustomCell.self, for: indexPath)
//            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
//            return cell
//        }
//        return super.collectionView(collectionView, cellForItemAt: indexPath)
//    }
//
//    // MARK: - MessagesDataSource
//
//    override func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        if isTimeLabelVisible(at: indexPath) {
//            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        }
//        return nil
//    }
//
//    override func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        if !isPreviousMessageSameSender(at: indexPath) {
//            let name = message.sender.displayName
//            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
//        }
//        return nil
//    }
//
//    override func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//
//        if !isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message) {
//            return NSAttributedString(string: "전송됨", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
//        }
//        return nil
//    }
//
//}
//
//// MARK: - MessagesDisplayDelegate
//
//extension MKPrivateChatView: MessagesDisplayDelegate {
//
//    // MARK: - Text Messages
//
//    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ? .white : .darkText
//    }
//
//    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
//        switch detector {
//        case .hashtag, .mention:
//            if isFromCurrentSender(message: message) {
//                return [.foregroundColor: UIColor.white]
//            } else {
//                return [.foregroundColor: UIColor.primaryColor]
//            }
//        default: return MessageLabel.defaultAttributes
//        }
//    }
//
//    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
//        return [.url, .address, .phoneNumber, .date, .transitInformation, .mention, .hashtag]
//    }
//
//    // MARK: - All Messages
//
//    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
////          return .primaryColor
//
//        return isFromCurrentSender(message: message) ? .primaryColor : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//    }
//
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//
//        var corners: UIRectCorner = []
//
//        if isFromCurrentSender(message: message) {
//            corners.formUnion(.topLeft)
//            corners.formUnion(.bottomLeft)
//            if !isPreviousMessageSameSender(at: indexPath) {
//                corners.formUnion(.topRight)
//            }
//            if !isNextMessageSameSender(at: indexPath) {
//                corners.formUnion(.bottomRight)
//            }
//        } else {
//            corners.formUnion(.topRight)
//            corners.formUnion(.bottomRight)
//            if !isPreviousMessageSameSender(at: indexPath) {
//                corners.formUnion(.topLeft)
//            }
//            if !isNextMessageSameSender(at: indexPath) {
//                corners.formUnion(.bottomLeft)
//            }
//        }
//
//        return .custom { view in
//            let radius: CGFloat = 16
//            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//            let mask = CAShapeLayer()
//            mask.path = path.cgPath
//            view.layer.mask = mask
//        }
//    }
//
////    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
////        let avatar = SampleData.shared.getAvatarFor(sender: message.sender)
////        avatarView.set(avatar: avatar)
////        avatarView.isHidden = isNextMessageSameSender(at: indexPath)
////        avatarView.layer.borderWidth = 2
////        avatarView.layer.borderColor = UIColor.primaryColor.cgColor
////    }
//
//    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        // Cells are reused, so only add a button here once. For real use you would need to
//        // ensure any subviews are removed if not needed
//        accessoryView.subviews.forEach { $0.removeFromSuperview() }
//        accessoryView.backgroundColor = .clear
//
//        let shouldShow = Int.random(in: 0...10) == 0
//        guard shouldShow else { return }
//
//        let button = UIButton(type: .infoLight)
//        button.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        accessoryView.addSubview(button)
//        button.frame = accessoryView.bounds
//        button.isUserInteractionEnabled = false // respond to accessoryView tap through `MessageCellDelegate`
//        accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
//        accessoryView.backgroundColor = UIColor.primaryColor.withAlphaComponent(0.3)
//    }
//
//    // MARK: - Location Messages
//
//    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
//        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
//        let pinImage = #imageLiteral(resourceName: "ic_map_marker")
//        annotationView.image = pinImage
//        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
//        return annotationView
//    }
//
//    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
//        return { view in
//            view.layer.transform = CATransform3DMakeScale(2, 2, 2)
//            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
//                view.layer.transform = CATransform3DIdentity
//            }, completion: nil)
//        }
//    }
//
//    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
//
//        return LocationMessageSnapshotOptions(showsBuildings: true, showsPointsOfInterest: true, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
//    }
//
//    // MARK: - Audio Messages
//
//    func audioTintColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return self.isFromCurrentSender(message: message) ? .white : .primaryColor
//    }
//
//    func configureAudioCell(_ cell: AudioMessageCell, message: MessageType) {
//        audioController.configureAudioCell(cell, message: message) // this is needed especily when the cell is reconfigure while is playing sound
//    }
//
//}
//
//// MARK: - MessagesLayoutDelegate
//
//extension MKPrivateChatView: MessagesLayoutDelegate {
//
//    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        if isTimeLabelVisible(at: indexPath) {
//            return 18
//        }
//        return 0
//    }
//
//    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        if isFromCurrentSender(message: message) {
//            return !isPreviousMessageSameSender(at: indexPath) ? 20 : 0
//        } else {
//            return !isPreviousMessageSameSender(at: indexPath) ? (20 + outgoingAvatarOverlap) : 0
//        }
//    }
//
//    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return (!isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message)) ? 16 : 0
//    }
//
//}
//
//
//
//
//extension MKPrivateChatView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//
//        let video = info[.mediaURL] as? URL
//        let photo = info[.editedImage] as? UIImage
//
//        messageSend(text: nil, photo: photo, video: video, audio: nil)
//
//        picker.dismiss(animated: true)
//    }
//
//    func messageSend(text: String?, photo: UIImage?, video: URL?, audio: String?) {
//
//        self.send(chatId: chatId, text: text, photo: photo, video: video, audio: audio)
//    }
//}
//extension MKPrivateChatView: StickersDelegate {
//
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    func didSelectSticker(sticker: UIImage) {
//
////        messageSend(text: nil, photo: sticker, video: nil, audio: nil)
//    }
//}
//extension MKPrivateChatView {
//
//    func send(chatId: String, text: String?, photo: UIImage?, video: URL?, audio: String?) {
//
//
//
//
//    }
//
//
//
//
//}
//


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
import MapKit
import MessageKit
import InputBarAccessoryView

class MKPrivateChatView: ChatViewController {
    

    
    @IBOutlet weak var contentView: UIView!
    let outgoingAvatarOverlap: CGFloat = 17.5
    var chat_title: String!

    private var isBlocker = false
    
//    private var messages: [Message] = []
//    private var messageListener: ListenerRegistration?
//

    
    
  
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        let button_translate = UIBarButtonItem(
               image: UIImage(named: "translate_icon"),
               style: .plain,
               target: self,
               
               action: #selector(selectLanguage)
           )
           
           let button_setting = UIBarButtonItem(
               image: UIImage(systemName: "gear"),
               style: .plain,
               target: self,
               action: #selector(showSetting)
           )
           button_setting.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           button_translate.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           self.title = chat_title
        
           self.navigationItem.rightBarButtonItems = [button_translate, button_setting]
        
 
    }
    @objc
    private func selectLanguage() {
        
    }
    
    @objc
    private func showSetting() {
        
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(false, animated: animated)
          navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
          navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
      }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    override func loadFirstMessages() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let count = UserDefaults.standard.mockMessagesCount()
////            SampleData.shared.getAdvancedMessages(count: count) { messages in
////                DispatchQueue.main.async {
////                    self.messageList = messages
////                    self.messagesCollectionView.reloadData()
////                    self.messagesCollectionView.scrollToBottom()
////                }
////            }
//        }
//    }
    
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
        layout?.setMessageOutgoingAvatarSize(.zero)
        layout?.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))
        layout?.setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))

        // Set outgoing avatar to overlap with the message bubble
        layout?.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: 18, bottom: outgoingAvatarOverlap, right: 0)))
        layout?.setMessageIncomingAvatarSize(CGSize(width: 30, height: 30))
        layout?.setMessageIncomingMessagePadding(UIEdgeInsets(top: -outgoingAvatarOverlap, left: -18, bottom: outgoingAvatarOverlap, right: 18))
        
        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))

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
        button.image = UIImage(systemName: "plus.circle.fill")
        button.setSize(CGSize(width: 42, height: 42), animated: false)
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
        
        let attributedString = NSAttributedString(string: "Title", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        ])
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let alertCamera = UIAlertAction(title: "카메라", style: .default) { action in
            ImagePicker.cameraMulti(target: self, edit: true)
        }
        let alertPhoto = UIAlertAction(title: "사진", style: .default) { action in
            ImagePicker.photoLibrary(target: self, edit: true)
        }
        let alertVideo = UIAlertAction(title: "비디오", style: .default) { action in
            ImagePicker.videoLibrary(target: self, edit: true)
        }
//        let alertAudio = UIAlertAction(title: "Audio", style: .default) { action in
////            self.actionAudio()
//        }
        let alertStickers = UIAlertAction(title: "스틱커", style: .default) { action in
            self.actionStickers()
        }
//        let alertLocation = UIAlertAction(title: "Location", style: .default) { action in
////            self.actionLocation()
//        }

        let configuration    = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        let imageCamera        = UIImage(systemName: "camera", withConfiguration: configuration)
        let imagePhoto        = UIImage(systemName: "photo", withConfiguration: configuration)
        let imageVideo        = UIImage(systemName: "play.rectangle", withConfiguration: configuration)
        let imageAudio        = UIImage(systemName: "music.mic", withConfiguration: configuration)
        let imageStickers    = UIImage(systemName: "tortoise", withConfiguration: configuration)
        let imageLocation    = UIImage(systemName: "location", withConfiguration: configuration)

        alertCamera.setValue(imageCamera, forKey: "image");     alert.addAction(alertCamera)
        alertPhoto.setValue(imagePhoto, forKey: "image");        alert.addAction(alertPhoto)
        alertVideo.setValue(imageVideo, forKey: "image");        alert.addAction(alertVideo)
//        alertAudio.setValue(imageAudio, forKey: "image");        alert.addAction(alertAudio)
        alertStickers.setValue(imageStickers, forKey: "image");    alert.addAction(alertStickers)
//        alertLocation.setValue(imageLocation, forKey: "image");    alert.addAction(alertLocation)
    
        alert.addAction(UIAlertAction(title: "취 소", style: .cancel))
        alert.setValue(attributedString, forKey: "attributedTitle")
        present(alert, animated: true)
    }
    
    func actionStickers() {

        let stickersView = StickersView()
        stickersView.delegate = self
        let navController = NavigationController(rootViewController: stickersView)
        present(navController, animated: true)
    }
    private func configureInputBarItems() {
//        let view_1 = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
//        view_1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//
//        let button_1 = UIButton(type: .system)
//        button_1.setImage(UIImage(named: "round_add_circle_black_18dp"), for: .normal)
//        button_1.frame = CGRect(x: 2, y: 2, width: 38, height: 38)
//        button_1.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//
//        button_1.tintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
//        view_1.addSubview(button_1)
//
//        button_1.addTarget(self, action: Selector(("didButtonClick:")), for: .touchUpInside)
//
//        messageInputBar.leftStackView.addSubview(button_1)
//
//        let button_2 = UIButton(type: .system)
//        button_2.setImage(UIImage(named: "round_sentiment_satisfied_black_18dp"), for: .normal)
//        button_2.frame = CGRect(x: -42, y: 2, width: 36, height: 36)
//        button_2.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        button_2.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        messageInputBar.rightStackView.addSubview(button_2)
//
//        button_1.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
////        button_2.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.sendButton.imageView?.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.sendButton.setImage(UIImage(named: "right-arrow"), for: .normal)
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
        updateTitleView(title: "김똘똘", subtitle: isHidden ? "2 온라인" : "입력중...")
        setTypingIndicatorViewHidden(isHidden, animated: true, whilePerforming: updates) { [weak self] success in
            if success, self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
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
            return NSAttributedString(string: "전송됨", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
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
        return isFromCurrentSender(message: message) ? .primaryColor : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        var corners: UIRectCorner = []
        
        if isFromCurrentSender(message: message) {
            corners.formUnion(.topLeft)
            corners.formUnion(.bottomLeft)
            if !isPreviousMessageSameSender(at: indexPath) {
                corners.formUnion(.topRight)
            }
            if !isNextMessageSameSender(at: indexPath) {
                corners.formUnion(.bottomRight)
            }
        } else {
            corners.formUnion(.topRight)
            corners.formUnion(.bottomRight)
            if !isPreviousMessageSameSender(at: indexPath) {
                corners.formUnion(.topLeft)
            }
            if !isNextMessageSameSender(at: indexPath) {
                corners.formUnion(.bottomLeft)
            }
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
        
        
        
//        let avatar = MessageVM.shared.getAvatarFor(sender: message.sender)
        
       avatarView.sd_setImage(with: URL(string: connectedPerson.user_avatar![0]), placeholderImage: UIImage(named: "avatar_woman"))
        
//        avatarView.set(avatar: avatar)
        avatarView.isHidden = isNextMessageSameSender(at: indexPath)
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = UIColor.primaryColor.cgColor
        
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
            return !isPreviousMessageSameSender(at: indexPath) ? 20 : 0
        } else {
            return !isPreviousMessageSameSender(at: indexPath) ? (20 + outgoingAvatarOverlap) : 0
        }
    }

    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return (!isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message)) ? 16 : 0
    }

}
extension MKPrivateChatView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        let video = info[.mediaURL] as? URL
        let photo = info[.editedImage] as? UIImage

        messageSend(text: nil, photo: photo, video: video, audio: nil)

        picker.dismiss(animated: true)
    }
    
    func messageSend(text: String?, photo: UIImage?, video: URL?, audio: String?) {

        self.send(chatId: chatId, text: text, photo: photo, video: video, audio: audio)
    }
}
extension MKPrivateChatView: StickersDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func didSelectSticker(sticker: UIImage) {

//        messageSend(text: nil, photo: sticker, video: nil, audio: nil)
    }
}
extension MKPrivateChatView {
    
    func send(chatId: String, text: String?, photo: UIImage?, video: URL?, audio: String?) {
        
        

    }
}
