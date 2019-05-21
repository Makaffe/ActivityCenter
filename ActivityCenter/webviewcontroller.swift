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
        /*let query:BmobQuery = BmobQuery(className: "activity")
        query.findObjectsInBackground { (array, error) in
            DispatchQueue.main.async {
                for i in 0..<array!.count{
                    let obj = array![i] as! BmobObject
                    let name = obj.object(forKey: "name") as! String
                    let lurl = obj.object(forKey: "linkurl") as!String
                    self.exTitle = name
                    self.url = lurl
                }*/
     super.viewDidLoad()
                self.title = self.exTitle
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        self.view.addSubview(webView)
                if let exUrl = URL(string: self.url!) {
            let request = URLRequest(url: exUrl)
            webView.load(request)
    }
      /*  func Get(){
            let query:BmobQuery = BmobQuery(className: "activity")
            query.findObjectsInBackground { (array, error) in
                DispatchQueue.main.async {
                    for i in 0..<array!.count{
                        let obj = array![i] as! BmobObject
                        let name = obj.object(forKey: "name") as! String
                        let lurl = obj.object(forKey: "linkurl") as!String
                        
                    }
                }
            }
            
        }*/
            
            
        
}
}

