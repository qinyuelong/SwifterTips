//
//  ViewController.swift
//  SwifterTips
//
//  Created by qinge on 2017/6/17.
//  Copyright © 2017年 qin. All rights reserved.
//  http://swifter.tips/

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let introductionDic = ["CurryingViewController" : "柯里化 (CURRYING)",
                           ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(introductionDic.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.textLabel?.text = Array(introductionDic.values)[indexPath.row]
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerString = parseViewControllerName(Array(introductionDic.values)[indexPath.row])
        if let classType = NSClassFromString(viewControllerString!) as? UIViewController.Type {
            let viewController = classType.init()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func parseViewControllerName(_ title: String) -> String? {
         for key in Array(introductionDic.keys) {
            let v = introductionDic[key]
            if v == title {
                return ("SwifterTips.\(key)")
            }
        }
        return nil
    }
    
}


