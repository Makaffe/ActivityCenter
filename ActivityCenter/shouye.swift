//
//  shouye.swift
//  ActivityCenter
//
//  Created by hph on 2019/4/28.
//  Copyright © 2019年 hph. All rights reserved.
//

import UIKit

class shouye: UIViewController,UITableViewDataSource,UITableViewDelegate {
     let exInfo = Model.exaidInfo
    var str1 :[String] = ["正在加载中"] , str2 : [String] = ["正在加载中"] ,str3 :[String] = ["正在加载中"] , str4 :[String] = ["正在加载中"] , str5:[UIImage]=[#imageLiteral(resourceName: "星空")]
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* self.tabBarItem.translucent = false  //避免受默认的半透明色影响，关闭
        
        self.tabBarItem.tintColor = UIColor.yellowColor() //设置选中颜色，这里使用黄色*/
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableview.dataSource = self
        tableview.delegate = self
        
        refreshControl.addTarget(self, action: #selector(shouye.refreshData),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableview.addSubview(refreshControl)
        
        Get()
        
        self.view.addSubview(tableview)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshData() {
        self.str1 = ["正在加载中"]
        self.str2 = ["正在加载中"]
        self.str3 = ["正在加载中"]
        self.str4 = ["正在加载中"]
        self.str5 = [#imageLiteral(resourceName: "星空")]
        Get()
        
        self.tableview.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func Get(){
        let query:BmobQuery = BmobQuery(className: "activity")
        query.findObjectsInBackground { (array, error) in
            DispatchQueue.main.async {
                self.str1 = []
                self.str2 = []
                self.str3 = []
                self.str4 = []
                for i in 0..<array!.count{
                    let obj = array![i] as! BmobObject
                    let name = obj.object(forKey: "name") as! String
                    let time = obj.object(forKey: "time") as! String
                    let address = obj.object(forKey: "address") as! String
                    let pic = obj.object(forKey: "url") as! String
                    self.str1.append(name)
                    self.str2.append(time)
                    self.str3.append(address)
                    self.str4.append(pic)
                }
                self.images()
            }
        }
        
    }
    
    func images(){
        self.str5 = []
        for i in 0..<self.str4.count{
            let url = URL(string: self.str4[i])!
        //创建请求对象
            let request = URLRequest(url: url)
        
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
                if error != nil{
                    print(error.debugDescription)
                    
                }else{
                //将图片数据赋予UIImage
                self.str5.append(UIImage(data: data!)!)
                    
                    if(self.str5.count==self.str4.count){
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                    }
                }
                
            }) as URLSessionTask
            dataTask.resume()
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str1.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 2;
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(named: "bg2")
       // let info = exInfo[indexPath.row]
        
        let label1 = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        let label3 = cell.viewWithTag(3) as! UILabel
        let image = cell.viewWithTag(4) as! UIImageView
        
        label1.text = self.str1[str1.count-1-indexPath.row]
        label2.text = self.str2[str1.count-1-indexPath.row]
        label3.text = self.str3[str1.count-1-indexPath.row]
        image.image = self.str5[str1.count-1-indexPath.row]
        
        
        
        tableView.rowHeight = 240
        
        return cell
    }
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "web" {
            let web = segue.destination as! webviewcontroller
            let info = exInfo[tableview.indexPathForSelectedRow!.row]
            web.url = info.url
            web.exTitle = info.name
            
        }
    }
    }


