//
//  zhuce.swift
//  ActivityCenter
//
//  Created by 龙弟 on 2019/5/4.
//  Copyright © 2019年 hph. All rights reserved.
//

import Foundation
import UIKit
class zhuce: UIViewController{
    @IBOutlet weak var us: UITextField!
    @IBOutlet weak var pw: UITextField!
    //@IBOutlet weak var pw2: UITextField!
    @IBOutlet weak var zc: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBAction func zc(_ sender: Any) {
        save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "jhk-15574902868110")
        self.view.insertSubview(backgroundImage, at: 0)
        us.backgroundColor=UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        pw.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
       // pw2.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.2)
        zc.layer.cornerRadius = 25
        zc.layer.masksToBounds = true
        back.layer.cornerRadius = 25
        back.layer.masksToBounds = true
        self.view.addSubview(zc)
        self.view.addSubview(back)
        self.view.addSubview(us)
        self.view.addSubview(pw)
        //self.view.addSubview(pw2)
    }
    func save(){
        
       // let Queue = DispatchQueue(label:"queue",attributes:[])
        
        let user = BmobUser()
        user.username = us.text
        user.password = pw.text
        //user.setObject(18, forKey: "age")
        user.signUpInBackground { (isSuccessful, error) in
                if isSuccessful {
                print("Sign up successfully")
                let alertController = UIAlertController(title: "系统提示", message: "注册成功", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
                alertController.addAction(okAction)
                self.present(alertController,animated: true, completion: nil)
            }else{
                    print("Sign up error\(String(describing: error))")
                let alertController = UIAlertController(title: "系统提示", message: "注册失败,密码或用户名为空", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
                alertController.addAction(okAction)
                self.present(alertController,animated: true, completion: nil)
            }
        }
    }
    }
