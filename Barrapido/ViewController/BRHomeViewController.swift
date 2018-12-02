//
//  BRHomeViewController.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 02/12/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import UIKit

class BRHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
      //  tableView.separatorColor = UIColor(red: 71/255, green: 59/255, blue: 141/255, alpha: 1)
    }
}

extension BRHomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let welcomeCellIdentifier = "welcomeCell"
        let barCodeScanCellIdentifier = "barCodeScanCell"
        let menuCellIdentifier = "menuCell"
        let orderCellIdentifier = "orderCell"
        
       // if indexPath.row == 0 {
        
            tableView.register(UINib(nibName: "WelcomeTableViewCell", bundle: nil), forCellReuseIdentifier: welcomeCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: welcomeCellIdentifier, for: indexPath) as! WelcomeTableViewCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
           cell.contentView.backgroundColor = UIColor(red: 179/255, green: 139/255, blue: 248/255, alpha: 1)
           return cell
        //}
        
      //  return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 400
    }
    
}
