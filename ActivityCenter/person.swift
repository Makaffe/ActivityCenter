//
//  person.swift
//  ActivityCenter
//
//  Created by 龙弟 on 2019/5/12.
//  Copyright © 2019年 hph. All rights reserved.
//

import UIKit

class person: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str =  String(indexPath.row+1)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell"+str)! as UITableViewCell
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 2;
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        tableView.rowHeight = 128
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
