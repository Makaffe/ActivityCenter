//
//  person2.swift
//  ActivityCenter
//
//  Created by 龙弟 on 2019/5/12.
//  Copyright © 2019年 hph. All rights reserved.
//

import UIKit

class person2: UIViewController,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var str = String(indexPath.row + 1)
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell"+str)! as UITableViewCell
        return cell;
    }
}

