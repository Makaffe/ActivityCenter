//
//  send.swift
//  ActivityCenter
//
//  Created by 龙弟 on 2019/5/9.
//  Copyright © 2019年 hph. All rights reserved.
//
import UIKit

class send: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var link: UITextField!
    
    var str:String=""
    
    var file:BmobFile!
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBAction func getimage(_ sender: Any) {
        showBottomAlert()
    }
    
    @IBAction func s(_ sender: Any) {
        
        if(!(name.text?.isEmpty)! && !(time.text?.isEmpty)! && !(address.text?.isEmpty)! && !str.isEmpty){
            insertData(key1:"name",key2:"time",key3:"address",key4:"url",key5:"linkurl")
            let alertController = UIAlertController(title: "系统提示", message: "发布成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
            alertController.addAction(okAction)
            self.present(alertController,animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "系统提示", message: "请先补全信息再发布", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler:{action in })
            alertController.addAction(okAction)
            self.present(alertController,animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func showBottomAlert(){
        
        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures=UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
            
        }
        let localPhoto=UIAlertAction(title:"本地图片", style: .default)
        {
            action in
            self.goImage()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
        
    }
    func goCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }
        
    }
    
    func goImage(){
        
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        print("获得照片============= \(info)")
        
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/image.jpg"
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        self.file = BmobFile.init(fileName: "img.jpg", withFileData: imageData)
        
        uploadFile(file: file)
        //显示设置的照片
        imageview.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    

    func uploadFile(file:BmobFile){
        
        print("start upload")
        
        //储存至云端
        
        file.saveInBackground{ (ret, error) in
            
            if(error != nil){
                
                print("error is \(error?.localizedDescription)")
                
            }else{
                
                self.str = file.url
                
            }
            
        }
    }
    
    func insertData(key1:String,key2:String,key3:String,key4:String,key5:String){
        
        //创建表
        
        let object = BmobObject(className: "activity")
        
        //设置数据对象
        
        object!.setObject(name.text, forKey: key1)
        object!.setObject(time.text, forKey: key2)
        object!.setObject(address.text, forKey: key3)
        object!.setObject(str, forKey: key4)
        object!.setObject(link.text, forKey: key5)
        
        
        //存储到云
        
        object!.saveInBackground { (ret, error) in
            
            if(error != nil){
                
                print("error is \(error!.localizedDescription)")
                
            }else{
                
                print("insert successful")
                
            }
            
        }
        
    }
    
}
