//
//  ViewController.swift
//  Component
//
//  Created by 吴杰健 on 16/12/27.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit

struct DemoData {
    
    let componentName: String
    let viewControllerName: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var demoDatas: [DemoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _initData()
    }

    fileprivate func _initData() {
        tableview.tableFooterView = UIView()
        let dic = [
            "RatingView": "RatingViewDemoViewController",
            "CarouselFigureView": "CarouselFigureViewDemoViewController",
            "LoadingView": "LoadingViewDemoViewController",
            "QRScan": "QRScanViewController"
        ]
        for (k, v) in dic {
            demoDatas.append(DemoData(componentName: k, viewControllerName: v))
        }
        tableview.reloadData()
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = demoDatas[indexPath.row].componentName
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcStr = demoDatas[indexPath.row].viewControllerName
        let vcType = NSClassFromString("Component.\(vcStr)") as! BaseViewController.Type
        let vc = vcType.init()
        vc.title = vcStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
