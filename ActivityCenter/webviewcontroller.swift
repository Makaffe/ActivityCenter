//
//  webviewcontroller.swift
//  ActivityCenter
//
//  Created by 龙弟 on 2019/5/19.
//  Copyright © 2019年 hph. All rights reserved.
//

import UIKit
import WebKit

class webviewcontroller:UITabBarController{
    var url: String?
     var exTitle: String?
    override func viewDidLoad() {
     super.viewDidLoad()
        self.title = exTitle
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        self.view.addSubview(webView)
        if let exUrl = URL(string: url!) {
            let request = URLRequest(url: exUrl)
            webView.load(request)
    
    
    }
        
            
            
        
}
}
