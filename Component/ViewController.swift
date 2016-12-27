//
//  ViewController.swift
//  Component
//
//  Created by 吴杰健 on 16/12/27.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aaa: RatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aaa.ratingModel = .Float
        aaa.setup(imageName: "star02", selectedImageName: "star01", touchEnable: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

