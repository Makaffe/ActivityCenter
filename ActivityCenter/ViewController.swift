//
//  ViewController.swift
//  ActivityCenter
//
//  Created by hph on 2019/4/23.
//  Copyright © 2019年 hph. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    var str1 :[String] = [] , str2 : [String] = [] ,str3 :[String] = [] ,str4 :[String] = []
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userPwd: UITextField!
    
    @IBOutlet weak var zhuce: UIButton!
    @IBAction func zhuce(_ sender: Any) {
        
    }
    @IBOutlet weak var login: UIButton!
    @IBAction func login(_ sender: Any) {
        getUser(u:userName.text!,p:userPwd.text!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        login.layer.cornerRadius = 25
        login.layer.masksToBounds = true
        zhuce.layer.cornerRadius = 25
        zhuce.layer.masksToBounds = true
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "jhk-15574902868110")
        self.view.insertSubview(backgroundImage, at: 0)
        userName.backgroundColor=UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        userPwd.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        self.view.addSubview(login)
        self.view.addSubview(zhuce)
        self.view.addSubview(userName)
        self.view.addSubview(userPwd)
        
        let defaults = UserDefaults.standard
        let name = defaults.object(forKey: "user") as?String
        defaults.set(userName.text, forKey: "user")
        UserDefaults.standard.synchronize
    
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getUser( u:String,p:String) {
        let Queue = DispatchQueue(label:"queue",attributes:[])
        BmobUser.loginWithUsername(inBackground: u, password: p)
        BmobUser.loginInbackground(withAccount: u, andPassword: p) { (user, error) in
            DispatchQueue.main.async {
                if user != nil{
                    let alertController = UIAlertController(title: "系统提示", message: "登陆成功", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
                    alertController.addAction(okAction)
                    self.present(alertController,animated: true, completion: nil)
                    let appD = UIApplication.shared.delegate as! AppDelegate
                    appD.autoVC()
                }
                else {
                    let alertController = UIAlertController(title: "系统提示", message: "登陆失败,用户名或者密码错误", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
                    alertController.addAction(okAction)
                    self.present(alertController,animated: true, completion: nil)
                }
            }
        }
        Queue.async {
            
        }
    }

}

