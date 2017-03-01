//
//  LoadingViewDemoViewController.swift
//  Component
//
//  Created by 吴杰健 on 17/3/1.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

class LoadingViewDemoViewController: BaseViewController {
    
    var loadingView: LoadingView?
    var touchedlalala = false
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    private func _init() {
        loadingView = LoadingView(frame: CGRect(x: 150, y: 200, width: 100, height: 100))
        loadingView?.setup()
        view.addSubview(loadingView!)
        
        let button = UIButton()
        button.setTitle("lksjf", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.frame.size = CGSize(width: 100, height: 40)
        button.center = CGPoint(x: screenWidth / 2, y: screenHeight - 100)
        button.addTarget(self, action: #selector(touched(button:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func touched(button: UIButton) {
        if !touchedlalala {
            loadingView?.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
            touchedlalala = true
        } else {
            loadingView?.loadingCompleted()
            button.removeFromSuperview()
        }
    }
    
    
}
