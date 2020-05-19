///*
//MIT License
//
//Copyright (c) 2017-2019 MessageKit
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//*/
//
//import UIKit
//import MessageKit
//import InputBarAccessoryView
//
///// A base class for the example controllers
//class ChatViewController: MessagesViewController, MessagesDataSource {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    /// The `BasicAudioController` controll the AVAudioPlayer state (play, pause, stop) and udpate audio cell UI accordingly.
//    open lazy var audioController = BasicAudioController(messageCollectionView: messagesCollectionView)
//
//    var messageList: [MockMessage] = []
//
//    let refreshControl = UIRefreshControl()
//
//    let formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }()
//
//    var chatId = ""
//    var recipientId = ""
//
//    var connected_person: person!
//    init(chatId: String,  connected_person: person) {
//
//            super.init(nibName: nil, bundle: nil)
//
//            self.chatId = chatId
//
//            self.connected_person = connected_person
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        MessageVM.shared.currentSender = MockUser(senderId: UserVM.current_user.user_id!, displayName: UserVM.current_user.user_nickName!)
////        MessageVM.shared.currentConnectedPerson = MockUser(senderId: connected_person.user_id!, displayName: connected_person.user_nickName!)
//
//        configureMessageCollectionView()
//        configureMessageInputBar()
//
//        loadBeforeMessages()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//
////        MockSocket.shared.connect(with: [MessageVM.shared.currentConnectedPerson])
////            .onNewMessage { [weak self] message in
////                self?.insertMessage(message)
////        }
////
//
//
//
//
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        MockSocket.shared.disconnect()
//        audioController.stopAnyOngoingPlaying()
//    }
//
//    func loadBeforeMessages() {
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            let count = UserDefaults.standard.mockMessagesCount()
//            MessageVM.shared.getMessages(count: count) { messages in
//                DispatchQueue.main.async {
//                    self.messageList = messages
//                    self.messagesCollectionView.reloadData()
//                    self.messagesCollectionView.scrollToBottom()
//                }
//            }
//        }
//
//    }
//
////    @objc
////    func loadMoreMessages() {
////        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
////
////            MessageVM.shared.getMessages(count: 20) { messages in
////                DispatchQueue.main.async {
////                    self.messageList.insert(contentsOf: messages, at: 0)
////                    self.messagesCollectionView.reloadDataAndKeepOffset()
////                    self.refreshControl.endRefreshing()
////                }
////            }
////
////        }
////
////    }
////
//    func configureMessageCollectionView() {
//
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messageCellDelegate = self
//
//        scrollsToBottomOnKeyboardBeginsEditing = true // default false
//        maintainPositionOnKeyboardFrameChanged = true // default false
//
//        messagesCollectionView.addSubview(refreshControl)
////        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
//    }
//
//    func configureMessageInputBar() {
//        messageInputBar.delegate = self
//        messageInputBar.inputTextView.tintColor = .primaryColor
//        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
//        messageInputBar.sendButton.setTitleColor(
//            UIColor.primaryColor.withAlphaComponent(0.3),
//            for: .highlighted
//        )
//    }
//
//    // MARK: - Helpers
//
//    func insertMessage(_ message: MockMessage) {
//        messageList.append(message)
//        // Reload last section to update header/footer labels and insert a new one
//        messagesCollectionView.performBatchUpdates({
//            messagesCollectionView.insertSections([messageList.count - 1])
//            if messageList.count >= 2 {
//                messagesCollectionView.reloadSections([messageList.count - 2])
//            }
//        }, completion: { [weak self] _ in
//            if self?.isLastSectionVisible() == true {
//                self?.messagesCollectionView.scrollToBottom(animated: true)
//            }
//        })
//    }
//
//    func isLastSectionVisible() -> Bool {
//
//        guard !messageList.isEmpty else { return false }
//
//        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
//
//        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
//    }
//
//    // MARK: - MessagesDataSource
//
//    func currentSender() -> SenderType {
//        return MessageVM.shared.currentSender
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messageList.count
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        return messageList[indexPath.section]
//    }
//
//    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
////        if indexPath.section % 3 == 0 {
//            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
////        }
////        return nil
//    }
//
//    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//
//        return NSAttributedString(string: "Read", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//    }
//
//    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        let name = message.sender.displayName
//        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
//    }
//
//    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//
//        let dateString = formatter.string(from: message.sentDate)
//        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
//    }
//
//}
//
//// MARK: - MessageCellDelegate
//
//extension ChatViewController: MessageCellDelegate {
//
//    func didTapAvatar(in cell: MessageCollectionViewCell) {
//        print("Avatar tapped")
//    }
//
//    func didTapMessage(in cell: MessageCollectionViewCell) {
//        print("Message tapped")
//    }
//
//    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
//        print("Top cell label tapped")
//    }
//
//    func didTapCellBottomLabel(in cell: MessageCollectionViewCell) {
//        print("Bottom cell label tapped")
//    }
//
//    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
//        print("Top message label tapped")
//    }
//
//    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
//        print("Bottom label tapped")
//    }
//
//    func didTapPlayButton(in cell: AudioMessageCell) {
//        guard let indexPath = messagesCollectionView.indexPath(for: cell),
//            let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath, in: messagesCollectionView) else {
//                print("Failed to identify message when audio cell receive tap gesture")
//                return
//        }
//        guard audioController.state != .stopped else {
//            // There is no audio sound playing - prepare to start playing for given audio message
//            audioController.playSound(for: message, in: cell)
//            return
//        }
//        if audioController.playingMessage?.messageId == message.messageId {
//            // tap occur in the current cell that is playing audio sound
//            if audioController.state == .playing {
//                audioController.pauseSound(for: message, in: cell)
//            } else {
//                audioController.resumeSound()
//            }
//        } else {
//            // tap occur in a difference cell that the one is currently playing sound. First stop currently playing and start the sound for given message
//            audioController.stopAnyOngoingPlaying()
//            audioController.playSound(for: message, in: cell)
//        }
//    }
//
//    func didStartAudio(in cell: AudioMessageCell) {
//        print("Did start playing audio sound")
//    }
//
//    func didPauseAudio(in cell: AudioMessageCell) {
//        print("Did pause audio sound")
//    }
//
//    func didStopAudio(in cell: AudioMessageCell) {
//        print("Did stop audio sound")
//    }
//
//    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
//        print("Accessory view tapped")
//    }
//
//}
//
//// MARK: - MessageLabelDelegate
//
//extension ChatViewController: MessageLabelDelegate {
//
//    func didSelectAddress(_ addressComponents: [String: String]) {
//        print("Address Selected: \(addressComponents)")
//    }
//
//    func didSelectDate(_ date: Date) {
//        print("Date Selected: \(date)")
//    }
//
//    func didSelectPhoneNumber(_ phoneNumber: String) {
//        print("Phone Number Selected: \(phoneNumber)")
//    }
//
//    func didSelectURL(_ url: URL) {
//        print("URL Selected: \(url)")
//    }
//
//    func didSelectTransitInformation(_ transitInformation: [String: String]) {
//        print("TransitInformation Selected: \(transitInformation)")
//    }
//
//    func didSelectHashtag(_ hashtag: String) {
//        print("Hashtag selected: \(hashtag)")
//    }
//
//    func didSelectMention(_ mention: String) {
//        print("Mention selected: \(mention)")
//    }
//
//    func didSelectCustom(_ pattern: String, match: String?) {
//        print("Custom data detector patter selected: \(pattern)")
//    }
//
//}
//
//// MARK: - MessageInputBarDelegate
//
//extension ChatViewController: InputBarAccessoryViewDelegate {
//
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//
//        // Here we can parse for which substrings were autocompleted
//        let attributedText = messageInputBar.inputTextView.attributedText!
//        let range = NSRange(location: 0, length: attributedText.length)
//        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in
//
//            let substring = attributedText.attributedSubstring(from: range)
//            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
//            print("Autocompleted: `", substring, "` with context: ", context ?? [])
//        }
//        let message_content  = messageInputBar.inputTextView.text
//        let components = inputBar.inputTextView.components
//        messageInputBar.inputTextView.text = String()
//        messageInputBar.invalidatePlugins()
//
//        // Send button activity animation
//        messageInputBar.sendButton.startAnimating()
//        messageInputBar.inputTextView.placeholder = "전송중..."
//
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "h:mm a"
//        formatter.amSymbol = "AM"
//        formatter.pmSymbol = "PM"
//
//        let time_string = formatter.string(from: Date())
//
//        let calendar = Calendar.current
//
//        let month_string = calendar.component(.month, from: Date())
//        let date_string = calendar.component(.day, from: Date())
//        let date = String(month_string) + "월 " +  String(date_string) + "일"
//
//        UserVM.shared.sendMessage(sender_id: chatId, receiver_id: connected_person.user_id!, text: message_content!, sourceType: "text", sourcePath: "", thumb_path: "", time: time_string, date: date) { (success, message, error) in
//
//
//                   if error == nil{
//                    if success{
//
//                        DispatchQueue.global(qos: .default).async {
//                            // fake send request task
//                            sleep(1)
//                            DispatchQueue.main.async { [weak self] in
//                                self?.messageInputBar.sendButton.stopAnimating()
//                                self?.messageInputBar.inputTextView.placeholder = "메쎄지를 입력하세요."
//                                self?.insertMessages(components)
//                                self?.messagesCollectionView.scrollToBottom(animated: true)
//                            }
//                        }
//                    }
//            }
//
//        }
//
//
//
//    }
//
//    private func insertMessages(_ data: [Any]) {
//
//        for component in data {
//
//            let user = MessageVM.shared.currentSender
//            if let str = component as? String {
//                let message = MockMessage(text: str, user: user, messageId: UUID().uuidString, date: Date())
//                insertMessage(message)
//            } else if let img = component as? UIImage {
//                let message = MockMessage(image: img, user: user, messageId: UUID().uuidString, date: Date())
//                insertMessage(message)
//            }
//        }
//
//    }
//
//
//}

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

/// A base class for the example controllers
class ChatViewController: MessagesViewController, MessagesDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// The `BasicAudioController` controll the AVAudioPlayer state (play, pause, stop) and udpate audio cell UI accordingly.
    open lazy var audioController = BasicAudioController(messageCollectionView: messagesCollectionView)

    var messageList: [MockMessage] = []
    
    var chatId = ""
    var connectedPerson: person!
    
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(chatId: String, connectedPerson: person) {

        super.init(nibName: nil, bundle: nil)

        self.chatId = chatId
        self.connectedPerson = connectedPerson

//        isBlocker = Blockeds.isBlocker(recipientId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMessageCollectionView()
        configureMessageInputBar()
        MessageVM.shared.geData(sender_id: chatId, connectedPerson: connectedPerson, completion: {_ in
            self.loadFirstMessages()
        })
        
       
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
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
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

        // Here we can parse for which substrings were autocompleted
        let attributedText = messageInputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }

        let components = inputBar.inputTextView.components
        let message_content  = messageInputBar.inputTextView.text
        messageInputBar.inputTextView.text = String()
        messageInputBar.invalidatePlugins()

        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "전송중..."
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
        
        UserVM.shared.sendMessage(sender_id: chatId, receiver_id: connectedPerson.user_id!, text: message_content!, sourceType: "text", sourcePath: "", thumb_path: "", time: time_string, date: date) { (success, message, error) in
        
        
                           if error == nil{
                            if success{
        
                                DispatchQueue.global(qos: .default).async {
                                    // fake send request task
                                    sleep(1)
                                    DispatchQueue.main.async { [weak self] in
                                        self?.messageInputBar.sendButton.stopAnimating()
                                        self?.messageInputBar.inputTextView.placeholder = "메쎄지를 입력하세요."
//                                        self?.insertMessages(components)
                                        self?.messagesCollectionView.scrollToBottom(animated: true)
                                    }
                                }
                            }
                    }
        
                }
        
 
    }

    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = MessageVM.shared.currentSender
            if let str = component as? String {
                let message = MockMessage(text: str, user: user!, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            } else if let img = component as? UIImage {
                let message = MockMessage(image: img, user: user!, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            }
        }
    }
}