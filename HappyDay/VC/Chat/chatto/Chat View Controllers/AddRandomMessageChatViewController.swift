/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

class AddRandomMessagesChatViewController: DemoChatViewController {
    
    
    var chat_title: String!
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
        self.dataSource.addRandomIncomingMessage()
    }
    
    @objc
    private func showSetting() {
        self.dataSource.addRandomIncomingMessage()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    
}
