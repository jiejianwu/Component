//
//  RatingViewDemoViewController.swift
//  Component
//
//  Created by 吴杰健 on 16/12/29.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit

class RatingViewDemoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ratingView = RatingView()
        ratingView.backgroundColor = UIColor.red
        ratingView.frame = CGRect(x: 20, y: 100, width: screenWidth - 40, height: 30)
        ratingView.setup(imageName: "star02", selectedImageName: "star01", touchEnable: true)
        self.view.addSubview(ratingView)
    }
    
}
