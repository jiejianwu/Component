//
//  CarouselFigureViewDemoViewController.swift
//  Component
//
//  Created by 吴杰健 on 17/1/3.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

class CarouselFigureViewDemoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    private func _init() {
        let v = CarouselFigureView(frame: CGRect(x: 0, y: 80, width: screenWidth, height: 100))
        v.setup(imageUrlDatas: [ImageUrlData(imageUrl: "http://dl.bizhi.sogou.com/images/2012/03/11/290288.jpg", touchEvent: ImageTouchEvent.None), ImageUrlData(imageUrl: "http://dl.bizhi.sogou.com/images/2012/04/10/165812.jpg", touchEvent: ImageTouchEvent.Web(url: "asdasd"))])
        v.delegate = self
        self.view.addSubview(v)

    }
    
}


extension CarouselFigureViewDemoViewController: CarouselFigureViewDelegate {
    
    func imageViewDidTouched(index: Int, event: ImageTouchEvent) {
        print(index)
        switch event {
        case .NativeViewController(let identifer):
            print("NativeViewController identifer -- \(identifer)")
        case .Web(let url):
            print("Web url -- \(url)")
        default:
            print("unknow")
        }
    }
    
}
