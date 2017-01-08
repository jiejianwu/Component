//
//  CarouselFigureCollectionViewCell.swift
//  Component
//
//  Created by 吴杰健 on 17/1/3.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

class CarouselFigureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarouselFigureCollectionViewCell"
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    fileprivate func _setup() {
        self.backgroundColor = UIColor.white
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFill
        imageView?.layer.masksToBounds = true
        imageView?.frame = self.bounds
        self.contentView.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    

}
