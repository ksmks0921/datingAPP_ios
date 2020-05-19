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
//import MessageKit
//import CoreLocation
//import AVFoundation
//import FirebaseDatabase
//import FirebaseAuth
//
////typealias responseCallBack = ((Bool, String?, NSError?) -> ())
//
//class MessageVM {
//
//    static let shared = MessageVM()
//
//    private init() {}
//
//    enum MessageTypes: String, CaseIterable {
//        case Text
//        case AttributedText
//        case Photo
//        case Video
//        case Audio
//        case Emoji
//        case Location
//        case Url
//        case Phone
//        case Custom
//        case ShareContact
//    }
//
//
//
//    let system = MockUser(senderId: "000000", displayName: "System")
//    let nathan = MockUser(senderId: "000001", displayName: "Nathan Tannar")
//    let steven = MockUser(senderId: "000002", displayName: "Steven Deutsch")
//    let wu = MockUser(senderId: "000003", displayName: "Wu Zhong")
//
//    lazy var senders = [nathan, steven, wu]
//
//    lazy var contactsToShare = [
//        MockContactItem(name: "System", initials: "S"),
//        MockContactItem(name: "Nathan Tannar", initials: "NT", emails: ["test@test.com"]),
//        MockContactItem(name: "Steven Deutsch", initials: "SD", phoneNumbers: ["+1-202-555-0114", "+1-202-555-0145"]),
//        MockContactItem(name: "Wu Zhong", initials: "WZ", phoneNumbers: ["202-555-0158"]),
//        MockContactItem(name: "+40 123 123", initials: "#", phoneNumbers: ["+40 123 123"]),
//        MockContactItem(name: "test@test.com", initials: "#", emails: ["test@test.com"])
//    ]
//
//    var currentSender: MockUser!
//    var currentConnectedPerson : MockUser!
//    let ref : DatabaseReference = Database.database().reference()
//
//     var messages = [MockMessage]()
//     var custom_messages =  [MessageItem]()
//
//
//
//    var now = Date()
//
//    let messageImages: [UIImage] = [#imageLiteral(resourceName: "logo_temp"), #imageLiteral(resourceName: "third")]
//    let emojis = [
//        "👍",
//        "😂😂😂",
//        "👋👋👋",
//        "😱😱😱",
//        "😃😃😃",
//        "❤️"
//    ]
//
//    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
//
//    let locations: [CLLocation] = [
//        CLLocation(latitude: 37.3118, longitude: -122.0312),
//        CLLocation(latitude: 33.6318, longitude: -100.0386),
//        CLLocation(latitude: 29.3358, longitude: -108.8311),
//        CLLocation(latitude: 39.3218, longitude: -127.4312),
//        CLLocation(latitude: 35.3218, longitude: -127.4314),
//        CLLocation(latitude: 39.3218, longitude: -113.3317)
//    ]
//
//    let sounds: [URL] = [Bundle.main.url(forResource: "sound1", withExtension: "m4a")!,
//                         Bundle.main.url(forResource: "sound2", withExtension: "m4a")!
//    ]
//
//    func attributedString(with text: String) -> NSAttributedString {
//        let nsString = NSString(string: text)
//        var mutableAttributedString = NSMutableAttributedString(string: text)
//        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
//        let range = NSRange(location: 0, length: nsString.length)
//
//        switch attributes[randomAttribute] {
//        case "Font1":
//            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
//        case "Font2":
//            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
//        case "Font3":
//            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
//        case "Font4":
//            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
//        case "Color":
//            mutableAttributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: range)
//        case "Combo":
//            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
//            let msg9Text = NSString(string: msg9String)
//            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))
//
//            msg9AttributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
//            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
//            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
//            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
//            msg9AttributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
//            mutableAttributedString = msg9AttributedText
//        default:
//            fatalError("Unrecognized attribute for mock message")
//        }
//
//        return NSAttributedString(attributedString: mutableAttributedString)
//    }
//
//    func dateAddingRandomTime() -> Date {
//        let randomNumber = Int(arc4random_uniform(UInt32(10)))
//        if randomNumber % 2 == 0 {
//            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
//            now = date
//            return date
//        } else {
//            let randomMinute = Int(arc4random_uniform(UInt32(59)))
//            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
//            now = date
//            return date
//        }
//    }
//
//    func randomMessageType() -> MessageTypes {
//        var messageTypes = [MessageTypes]()
//        for type in MessageTypes.allCases {
//            if UserDefaults.standard.bool(forKey: "\(type.rawValue)" + " Messages") {
//                messageTypes.append(type)
//            }
//        }
//        return messageTypes.random()!
//    }
//
//    // swiftlint:disable cyclomatic_complexity
//    func randomMessage(allowedSenders: [MockUser]) -> MockMessage {
//        let randomNumberSender = Int(arc4random_uniform(UInt32(allowedSenders.count)))
//
//        let uniqueID = UUID().uuidString
//        let user = allowedSenders[randomNumberSender]
//        let date = dateAddingRandomTime()
//
//        switch randomMessageType() {
//        case .Text:
//            let randomSentence = Lorem.sentence()
//            return MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
//        case .AttributedText:
//            let randomSentence = Lorem.sentence()
//            let attributedText = attributedString(with: randomSentence)
//            return MockMessage(attributedText: attributedText, user: user, messageId: uniqueID, date: date)
//        case .Photo:
//            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
//            let image = messageImages[randomNumberImage]
//            return MockMessage(image: image, user: user, messageId: uniqueID, date: date)
//        case .Video:
//            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
//            let image = messageImages[randomNumberImage]
//            return MockMessage(thumbnail: image, user: user, messageId: uniqueID, date: date)
//        case .Audio:
//            let randomNumberSound = Int(arc4random_uniform(UInt32(sounds.count)))
//            let soundURL = sounds[randomNumberSound]
//            return MockMessage(audioURL: soundURL, user: user, messageId: uniqueID, date: date)
//        case .Emoji:
//            let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
//            return MockMessage(emoji: emojis[randomNumberEmoji], user: user, messageId: uniqueID, date: date)
//        case .Location:
//            let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
//            return MockMessage(location: locations[randomNumberLocation], user: user, messageId: uniqueID, date: date)
//        case .Url:
//            return MockMessage(text: "https://github.com/MessageKit", user: user, messageId: uniqueID, date: date)
//        case .Phone:
//            return MockMessage(text: "123-456-7890", user: user, messageId: uniqueID, date: date)
//        case .Custom:
//            return MockMessage(custom: "Someone left the conversation", user: system, messageId: uniqueID, date: date)
//        case .ShareContact:
//            let randomContact = Int(arc4random_uniform(UInt32(contactsToShare.count)))
//            return MockMessage(contact: contactsToShare[randomContact], user: user, messageId: uniqueID, date: date)
//        }
//    }
//    // swiftlint:enable cyclomatic_complexity
//
//    func getMessages(count: Int, completion: @escaping ([MockMessage]) -> Void) {
//
////
//        var messages: [MockMessage] = []
////        // Disable Custom Messages
//        UserDefaults.standard.set(false, forKey: "Custom Messages")
//        for _ in 0..<count {
//            let uniqueID = UUID().uuidString
//            let user = senders.random()!
//            let date = dateAddingRandomTime()
//            let randomSentence = Lorem.sentence()
//            let message = MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
//            messages.append(message)
//        }
//        completion(messages)
//
//
//
//
//
////                ref.child(FireBaseConstant.Chats).observe(.value) { (snapShot) in
////
////                       let children = snapShot.children
////                       self.messages.removeAll()
////                       while let rest = children.nextObject() as? DataSnapshot {
////                           if let restDict = rest.value as? NSDictionary{
////
////                                    let chinese = restDict[FireBaseConstant.lang_chinese] as? String
////                                    let date = restDict[FireBaseConstant.mdate] as? String
////                                    let english = restDict[FireBaseConstant.lang_english] as? String
////                                    let is_seen = restDict[FireBaseConstant.misseen] as? Bool
////                                    let japanese = restDict[FireBaseConstant.lang_japanese] as? String
////                                    let korean = restDict[FireBaseConstant.lang_korean] as? String
////                                    let message = restDict[FireBaseConstant.message] as? String
////                                    let  receiver = restDict[FireBaseConstant.mreceiver] as? String
////                                    let  sender = restDict[FireBaseConstant.msender] as? String
////                                    let source_path = restDict[FireBaseConstant.msource_path] as? String
////                                    let source_type = restDict[FireBaseConstant.msource_type] as? String
////                                    let thumb_path = restDict[FireBaseConstant.mthumb_path] as? String
////                                    let time = restDict[FireBaseConstant.mtime] as? String
////                                    let custom_message_item = MessageItem(chinese: chinese!, date: date!, english: english!, isseen: is_seen!, japanese: japanese!, korean: korean!, message: message!, receiver: receiver!, sender: sender!, source_path: source_path!, source_type: source_type!, thumb_path: thumb_path!, time:time!)
////                                    if (custom_message_item.receiver == MessageVM.shared.currentSender.senderId && custom_message_item.sender == MessageVM.shared.currentConnectedPerson.senderId) || (custom_message_item.receiver == MessageVM.shared.currentConnectedPerson.senderId && custom_message_item.sender == MessageVM.shared.currentSender.senderId) {
////
////                                        self.custom_messages.append(custom_message_item)
////                                            let user = MessageVM.shared.currentConnectedPerson
////                                            let uniqueID = UUID().uuidString
////                                            let date = self.dateAddingRandomTime()
////                                        let original_message = MockMessage(text: custom_message_item.message!, user: user!, messageId: uniqueID, date: date)
////                                        self.messages.append(original_message)
////
////
////
////                                    }
////
////
////                            }
////
////                       }
////
////                    print("________")
////                    print(self.messages.count)
////                    completion(self.messages)
////
////                }
//
//
//    }
//
//
//
//    func getAdvancedMessages(count: Int, completion: ([MockMessage]) -> Void) {
//
////        var mock_messages: [MockMessage] = []
////        var custom_messages : [MessageItem] = []
////        // Enable Custom Messages
////        UserDefaults.standard.set(true, forKey: "Custom Messages")
////
//////
//////        for _ in 0..<count {
//////            let message = randomMessage(allowedSenders: senders)
//////            mock_messages.append(message)
//////        }
//////
////        ref.child(FireBaseConstant.Chats).observe(.value) { (snapShot) in
////
////               let children = snapShot.children
////
////               while let rest = children.nextObject() as? DataSnapshot {
////                   if let restDict = rest.value as? NSDictionary{
////
////                            let chinese = restDict[FireBaseConstant.lang_chinese] as? String
////                            let date = restDict[FireBaseConstant.mdate] as? String
////                            let english = restDict[FireBaseConstant.lang_english] as? String
////                            let is_seen = restDict[FireBaseConstant.misseen] as? Bool
////                            let japanese = restDict[FireBaseConstant.lang_japanese] as? String
////                            let korean = restDict[FireBaseConstant.lang_korean] as? String
////                            let message = restDict[FireBaseConstant.message] as? String
////                            let  receiver = restDict[FireBaseConstant.mreceiver] as? String
////                            let  sender = restDict[FireBaseConstant.msender] as? String
////                            let source_path = restDict[FireBaseConstant.msource_path] as? String
////                            let source_type = restDict[FireBaseConstant.msource_type] as? String
////                            let thumb_path = restDict[FireBaseConstant.mthumb_path] as? String
////                            let time = restDict[FireBaseConstant.mtime] as? String
////                            let custom_message_item = MessageItem(chinese: chinese!, date: date!, english: english!, isseen: is_seen!, japanese: japanese!, korean: korean!, message: message!, receiver: receiver!, sender: sender!, source_path: source_path!, source_type: source_type!, thumb_path: thumb_path!, time:time!)
////                            if custom_message_item.receiver == MessageVM.shared.currentSender.senderId && custom_message_item.sender == MessageVM.shared.currentConnectedPerson.senderId {
////
////                                    custom_messages.append(custom_message_item)
////                                    let user = MessageVM.shared.currentConnectedPerson
////                                    let uniqueID = UUID().uuidString
////                                    let date = self.dateAddingRandomTime()
////                                let original_message = MockMessage(text: custom_message_item.message!, user: user!, messageId: uniqueID, date: date)
////                                    mock_messages.append(original_message)
////
////
////                            }
////
////
////                    }
////
////               }
////
////
////
////        }
////
////        completion(mock_messages)
//
//    }
//
//    func getMessages(count: Int, allowedSender: MockUser, completion: ([MockMessage]) -> Void) {
//
//        var mock_messages: [MockMessage] = []
//        var custom_messages : [MessageItem] = []
//        // Disable Custom Messages
//        UserDefaults.standard.set(false, forKey: "Custom Messages")
//
////        ref.child(FireBaseConstant.Chats).observe(.value) { (snapShot) in
////
////               let children = snapShot.children
////
////               while let rest = children.nextObject() as? DataSnapshot {
////                   if let restDict = rest.value as? NSDictionary{
////
////                            let chinese = restDict[FireBaseConstant.lang_chinese] as? String
////                            let date = restDict[FireBaseConstant.mdate] as? String
////                            let english = restDict[FireBaseConstant.lang_english] as? String
////                            let is_seen = restDict[FireBaseConstant.misseen] as? Bool
////                            let japanese = restDict[FireBaseConstant.lang_japanese] as? String
////                            let korean = restDict[FireBaseConstant.lang_korean] as? String
////                            let message = restDict[FireBaseConstant.message] as? String
////                            let  receiver = restDict[FireBaseConstant.mreceiver] as? String
////                            let  sender = restDict[FireBaseConstant.msender] as? String
////                            let source_path = restDict[FireBaseConstant.msource_path] as? String
////                            let source_type = restDict[FireBaseConstant.msource_type] as? String
////                            let thumb_path = restDict[FireBaseConstant.mthumb_path] as? String
////                            let time = restDict[FireBaseConstant.mtime] as? String
////                            let custom_message_item = MessageItem(chinese: chinese!, date: date!, english: english!, isseen: is_seen!, japanese: japanese!, korean: korean!, message: message!, receiver: receiver!, sender: sender!, source_path: source_path!, source_type: source_type!, thumb_path: thumb_path!, time:time!)
////                            if custom_message_item.receiver == MessageVM.shared.currentSender.senderId && custom_message_item.sender == MessageVM.shared.currentConnectedPerson.senderId {
////
////                                    custom_messages.append(custom_message_item)
////                                    let user = allowedSender
////                                    let uniqueID = UUID().uuidString
////                                let date = self.dateAddingRandomTime()
////                                    let original_message = MockMessage(text: custom_message_item.message!, user: user, messageId: uniqueID, date: date)
////                                    mock_messages.append(original_message)
////
////
////                            }
////
////
////                    }
////
////               }
////
////
////
////        }
//
//        completion(mock_messages)
//
//
//
//
//
//
//
//    }
//
//    func getAvatarFor(sender: SenderType) -> Avatar {
//        let firstName = sender.displayName.components(separatedBy: " ").first
//        let lastName = sender.displayName.components(separatedBy: " ").first
//        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
//        switch sender.senderId {
//        case "000001":
//            return Avatar(image: #imageLiteral(resourceName: "logo_temp"), initials: initials)
//        case "000002":
//            return Avatar(image: #imageLiteral(resourceName: "sharp_cancel_black_18dp"), initials: initials)
//        case "000003":
//            return Avatar(image: #imageLiteral(resourceName: "outline_schedule_black_18dp"), initials: initials)
//        case "000000":
//            return Avatar(image: nil, initials: "SS")
//        default:
//            return Avatar(image: nil, initials: initials)
//        }
//    }
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

import MessageKit
import CoreLocation
import AVFoundation
import FirebaseDatabase
import FirebaseAuth

final internal class MessageVM {

    static let shared = MessageVM()

    private init() {}

    enum MessageTypes: String, CaseIterable {
        case Text
        case AttributedText
        case Photo
        case Video
        case Audio
        case Emoji
        case Location
        case Url
        case Phone
        case Custom
        case ShareContact
    }

    let system = MockUser(senderId: "000000", displayName: "System")
    let nathan = MockUser(senderId: "000001", displayName: "Nathan Tannar")
    let steven = MockUser(senderId: "000002", displayName: "Steven Deutsch")
    let wu = MockUser(senderId: "000003", displayName: "Wu Zhong")

    lazy var senders = [nathan, steven, wu]
    
    lazy var contactsToShare = [
        MockContactItem(name: "System", initials: "S"),
        MockContactItem(name: "Nathan Tannar", initials: "NT", emails: ["test@test.com"]),
        MockContactItem(name: "Steven Deutsch", initials: "SD", phoneNumbers: ["+1-202-555-0114", "+1-202-555-0145"]),
        MockContactItem(name: "Wu Zhong", initials: "WZ", phoneNumbers: ["202-555-0158"]),
        MockContactItem(name: "+40 123 123", initials: "#", phoneNumbers: ["+40 123 123"]),
        MockContactItem(name: "test@test.com", initials: "#", emails: ["test@test.com"])
    ]

//    var currentSender: MockUser {
//        return steven
//    }
    var currentSender: MockUser!
    var now = Date()
    
    let messageImages: [UIImage] = [#imageLiteral(resourceName: "logo_temp"), #imageLiteral(resourceName: "third")]
    let emojis = [
        "👍",
        "😂😂😂",
        "👋👋👋",
        "😱😱😱",
        "😃😃😃",
        "❤️"
    ]
    let ref : DatabaseReference = Database.database().reference()
    
    var messages = [MockMessage]()
    var custom_messages =  [MessageItem]()
    var currentConnectedPerson : MockUser!
    var custom_currentConnectedPerson : MessageItem!
    var chatList = [ChatList]()
    var chatListItems = [ChatListItem]()
    
    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
    
    let locations: [CLLocation] = [
        CLLocation(latitude: 37.3118, longitude: -122.0312),
        CLLocation(latitude: 33.6318, longitude: -100.0386),
        CLLocation(latitude: 29.3358, longitude: -108.8311),
        CLLocation(latitude: 39.3218, longitude: -127.4312),
        CLLocation(latitude: 35.3218, longitude: -127.4314),
        CLLocation(latitude: 39.3218, longitude: -113.3317)
    ]

    let sounds: [URL] = [Bundle.main.url(forResource: "sound1", withExtension: "m4a")!,
                         Bundle.main.url(forResource: "sound2", withExtension: "m4a")!
    ]

    func attributedString(with text: String) -> NSAttributedString {
        let nsString = NSString(string: text)
        var mutableAttributedString = NSMutableAttributedString(string: text)
        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
        let range = NSRange(location: 0, length: nsString.length)
        
        switch attributes[randomAttribute] {
        case "Font1":
            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
        case "Font2":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
        case "Font3":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Font4":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Color":
            mutableAttributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: range)
        case "Combo":
            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
            let msg9Text = NSString(string: msg9String)
            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))
            
            msg9AttributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
            mutableAttributedString = msg9AttributedText
        default:
            fatalError("Unrecognized attribute for mock message")
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }

    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }
    
    func randomMessageType() -> MessageTypes {
        var messageTypes = [MessageTypes]()
        for type in MessageTypes.allCases {
            if UserDefaults.standard.bool(forKey: "\(type.rawValue)" + " Messages") {
                messageTypes.append(type)
            }
        }
        return messageTypes.random()!
    }

    // swiftlint:disable cyclomatic_complexity
    func randomMessage(allowedSenders: [MockUser]) -> MockMessage {
        let randomNumberSender = Int(arc4random_uniform(UInt32(allowedSenders.count)))
        
        let uniqueID = UUID().uuidString
        let user = allowedSenders[randomNumberSender]
        let date = dateAddingRandomTime()

        switch randomMessageType() {
        case .Text:
            let randomSentence = Lorem.sentence()
            return MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
        case .AttributedText:
            let randomSentence = Lorem.sentence()
            let attributedText = attributedString(with: randomSentence)
            return MockMessage(attributedText: attributedText, user: user, messageId: uniqueID, date: date)
        case .Photo:
            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
            let image = messageImages[randomNumberImage]
            return MockMessage(image: image, user: user, messageId: uniqueID, date: date)
        case .Video:
            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
            let image = messageImages[randomNumberImage]
            return MockMessage(thumbnail: image, user: user, messageId: uniqueID, date: date)
        case .Audio:
            let randomNumberSound = Int(arc4random_uniform(UInt32(sounds.count)))
            let soundURL = sounds[randomNumberSound]
            return MockMessage(audioURL: soundURL, user: user, messageId: uniqueID, date: date)
        case .Emoji:
            let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
            return MockMessage(emoji: emojis[randomNumberEmoji], user: user, messageId: uniqueID, date: date)
        case .Location:
            let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
            return MockMessage(location: locations[randomNumberLocation], user: user, messageId: uniqueID, date: date)
        case .Url:
            return MockMessage(text: "https://github.com/MessageKit", user: user, messageId: uniqueID, date: date)
        case .Phone:
            return MockMessage(text: "123-456-7890", user: user, messageId: uniqueID, date: date)
        case .Custom:
            return MockMessage(custom: "Someone left the conversation", user: system, messageId: uniqueID, date: date)
        case .ShareContact:
            let randomContact = Int(arc4random_uniform(UInt32(contactsToShare.count)))
            return MockMessage(contact: contactsToShare[randomContact], user: user, messageId: uniqueID, date: date)
        }
    }
    
    func geData(sender_id: String, connectedPerson: person, completion: @escaping (Bool) -> Void) {
    
    
                 
                    self.currentSender = MockUser(senderId: sender_id, displayName: UserVM.current_user.user_nickName!)
                    self.currentConnectedPerson = MockUser(senderId: connectedPerson.user_id!, displayName: connectedPerson.user_nickName!)

                    // get message data
                    ref.child(FireBaseConstant.Chats).observe(.value) { (snapShot) in
                
                           let children = snapShot.children
                        
                           self.custom_messages.removeAll()
                           self.messages.removeAll()
                           while let rest = children.nextObject() as? DataSnapshot {
                               if let restDict = rest.value as? NSDictionary{
    
                                        let chinese = restDict[FireBaseConstant.lang_chinese] as? String
                                        let date = restDict[FireBaseConstant.mdate] as? String
                                        let english = restDict[FireBaseConstant.lang_english] as? String
                                        let is_seen = restDict[FireBaseConstant.misseen] as? Bool
                                        let japanese = restDict[FireBaseConstant.lang_japanese] as? String
                                        let korean = restDict[FireBaseConstant.lang_korean] as? String
                                        let message = restDict[FireBaseConstant.message] as? String
                                        let receiver = restDict[FireBaseConstant.mreceiver] as? String
                                        let sender = restDict[FireBaseConstant.msender] as? String
                                        let source_path = restDict[FireBaseConstant.msource_path] as? String
                                        let source_type = restDict[FireBaseConstant.msource_type] as? String
                                        let thumb_path = restDict[FireBaseConstant.mthumb_path] as? String
                                        let time = restDict[FireBaseConstant.mtime] as? String
                                        let custom_message_item = MessageItem(chinese: chinese!, date: date!, english: english!, isseen: is_seen!, japanese: japanese!, korean: korean!, message: message!, receiver: receiver!, sender: sender!, source_path: source_path!, source_type: source_type!, thumb_path: thumb_path!, time:time!)
                                
                                if (custom_message_item.receiver == sender_id && custom_message_item.sender == connectedPerson.user_id) || (custom_message_item.receiver == connectedPerson.user_id && custom_message_item.sender == sender_id) {
                                            
                                   
                                            self.custom_messages.append(custom_message_item)
                                            let user: MockUser!
                                            if custom_message_item.sender == sender_id {
                                                user = MessageVM.shared.currentSender
                                            }
                                            else {
                                                user = MessageVM.shared.currentConnectedPerson
                                            }
                                            let uniqueID = UUID().uuidString
                                            let date = self.dateAddingRandomTime()
                                                let original_message = MockMessage(text: custom_message_item.message!, user: user!, messageId: uniqueID, date: date)
                                            self.messages.append(original_message)
                                       
    
    
                                        }
    
    
                                }
    
                           }
    
                    print("________")
                    print(self.messages.count)
                   
                    completion(true)
                }
                    
    
    }
    
    func getChatListId(completion: @escaping (Bool) -> Void){
            
        ref.child(FireBaseConstant.Chatlist).child(UserVM.current_user.user_id!).observe(.value) { (snapShot) in
                let children = snapShot.children
                self.chatList.removeAll()
                while let rest = children.nextObject() as? DataSnapshot {
                    if let restDict = rest.value as? NSDictionary{
                        let id = restDict[FireBaseConstant.l_id] as? String
                        let status = restDict[FireBaseConstant.l_status] as? String
                        let list_item = ChatList(id: id!, status: status!)
                        
                        self.chatList.append(list_item)
                    }
                }
          
               completion(true)
        }
    }
    
    func getChatListContents(completion: @escaping (Bool) -> Void){
        
        
        
        
        
        ref.child(FireBaseConstant.Chatlist).child(UserVM.current_user.user_id!).observe(.value) { (snapShot) in
                let children = snapShot.children
            
                self.chatList.removeAll()
                self.chatListItems.removeAll()
            
                while let rest = children.nextObject() as? DataSnapshot {
                    if let restDict = rest.value as? NSDictionary{
                        let id = restDict[FireBaseConstant.l_id] as? String
                        let status = restDict[FireBaseConstant.l_status] as? String
                        
                        
                        
                        let person_list = self.getDataFromUsers(id: id!)
                        let avatar = person_list.user_avatar
                        let age = person_list.user_age
                        let region = person_list.user_city
                        let nick_name = person_list.user_nickName
//
//                        let last_message = self.getLastMessageData(sender_id: UserVM.current_user.user_id!, connectedPerson: person_list)
//                        let date = last_message.date
//                        let time = last_message.time
//                        let last_message_content = last_message.message
//                        let list_item = ChatListItem(avatar: avatar![0], nick_name: nick_name!,  age: age!, region:region!, last_message:last_message_content!, last_connect_time: time!, last_connect_date: date!)
                        
                        self.geData(sender_id: UserVM.current_user.user_id!, connectedPerson: person_list, completion: {_ in

                            let last_message = self.custom_messages[self.custom_messages.count - 1].message

                            let time = self.custom_messages[self.custom_messages.count - 1].time
                            let date = self.custom_messages[self.custom_messages.count - 1].date
//                            let time_date = time! + " " + date!
                            
                            print("_________")
                            print(time)
                            print("_________")
                            print(date)

                        })
                        let list_item = ChatListItem(avatar: avatar![0], nick_name: nick_name!,  age: age!, region:region!, last_message:"last_message", last_connect_time: "time", last_connect_date: "date", id: person_list.user_id!)


                        self.chatListItems.append(list_item)
                        
                    }
                }
                print("_________")
                print(self.chatListItems.count)
                completion(true)
        }
    }
    
    func getLastMessageData(sender_id: String, connectedPerson: person) -> MessageItem {
    
    
                    var return_data : MessageItem!
                    self.currentSender = MockUser(senderId: sender_id, displayName: UserVM.current_user.user_nickName!)
                    self.currentConnectedPerson = MockUser(senderId: connectedPerson.user_id!, displayName: connectedPerson.user_nickName!)

                    // get message data
                    ref.child(FireBaseConstant.Chats).observe(.value) { (snapShot) in
                
                           let children = snapShot.children
                        
                           self.custom_messages.removeAll()
                           self.messages.removeAll()
                           while let rest = children.nextObject() as? DataSnapshot {
                               if let restDict = rest.value as? NSDictionary{
    
                                        let chinese = restDict[FireBaseConstant.lang_chinese] as? String
                                        let date = restDict[FireBaseConstant.mdate] as? String
                                        let english = restDict[FireBaseConstant.lang_english] as? String
                                        let is_seen = restDict[FireBaseConstant.misseen] as? Bool
                                        let japanese = restDict[FireBaseConstant.lang_japanese] as? String
                                        let korean = restDict[FireBaseConstant.lang_korean] as? String
                                        let message = restDict[FireBaseConstant.message] as? String
                                        let receiver = restDict[FireBaseConstant.mreceiver] as? String
                                        let sender = restDict[FireBaseConstant.msender] as? String
                                        let source_path = restDict[FireBaseConstant.msource_path] as? String
                                        let source_type = restDict[FireBaseConstant.msource_type] as? String
                                        let thumb_path = restDict[FireBaseConstant.mthumb_path] as? String
                                        let time = restDict[FireBaseConstant.mtime] as? String
                                        let custom_message_item = MessageItem(chinese: chinese!, date: date!, english: english!, isseen: is_seen!, japanese: japanese!, korean: korean!, message: message!, receiver: receiver!, sender: sender!, source_path: source_path!, source_type: source_type!, thumb_path: thumb_path!, time:time!)
                                
                                if (custom_message_item.receiver == sender_id && custom_message_item.sender == connectedPerson.user_id) || (custom_message_item.receiver == connectedPerson.user_id && custom_message_item.sender == sender_id) {
                                            
                                   
                                            self.custom_messages.append(custom_message_item)
                                            let user: MockUser!
                                            if custom_message_item.sender == sender_id {
                                                user = MessageVM.shared.currentSender
                                            }
                                            else {
                                                user = MessageVM.shared.currentConnectedPerson
                                            }
                                            let uniqueID = UUID().uuidString
                                            let date = self.dateAddingRandomTime()
                                                let original_message = MockMessage(text: custom_message_item.message!, user: user!, messageId: uniqueID, date: date)
                                            self.messages.append(original_message)
                                       
    
    
                                        }
    
    
                                }
    
                           }
                    return_data = self.custom_messages[self.custom_messages.count - 1]
               
                   
                }
                return return_data
    
    }
    
    func getDataFromUsers(id: String) -> person{
        var target_user: person!
        for user_item in UserVM.users {
            
            if user_item.user_id == id {
                
               target_user = user_item
                
            }
            
        }
        return target_user
    }

    // swiftlint:enable cyclomatic_complexity
    
    func getMessages(count: Int, completion: ([MockMessage]) -> Void) {
//        var messages: [MockMessage] = []
        // Disable Custom Messages
//        UserDefaults.standard.set(false, forKey: "Custom Messages")
//        for _ in 0..<count {
//            let uniqueID = UUID().uuidString
//            let user = senders.random()!
//            let date = dateAddingRandomTime()
//            let randomSentence = Lorem.sentence()
//            let message = MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
//            messages.append(message)
//        }
        completion(self.messages)
        
        
    }
    
    func getAdvancedMessages(count: Int, completion: ([MockMessage]) -> Void) {
        var messages: [MockMessage] = []
        // Enable Custom Messages
        UserDefaults.standard.set(true, forKey: "Custom Messages")
        for _ in 0..<count {
            let message = randomMessage(allowedSenders: senders)
            messages.append(message)
        }
        completion(messages)
    }
    
    func getMessages(count: Int, allowedSenders: [MockUser], completion: ([MockMessage]) -> Void) {
        var messages: [MockMessage] = []
        // Disable Custom Messages
        UserDefaults.standard.set(false, forKey: "Custom Messages")
        for _ in 0..<count {
            let uniqueID = UUID().uuidString
            let user = senders.random()!
            let date = dateAddingRandomTime()
            let randomSentence = Lorem.sentence()
            let message = MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
            messages.append(message)
        }
        completion(messages)
    }

    func getAvatarFor(sender: SenderType) ->  Avatar{
        let firstName = sender.displayName.components(separatedBy: " ").first
        let lastName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
        
        
        switch sender.senderId {
        case "000001":
            return Avatar(image: #imageLiteral(resourceName: "logo_temp"), initials: initials)
        case "000002":
            return Avatar(image: #imageLiteral(resourceName: "sharp_cancel_black_18dp"), initials: initials)
        case "000003":
            return Avatar(image: #imageLiteral(resourceName: "outline_schedule_black_18dp"), initials: initials)
        case "000000":
            return Avatar(image: nil, initials: "SS")
        default:
            return Avatar(image: nil, initials: initials)
        }
    }

}