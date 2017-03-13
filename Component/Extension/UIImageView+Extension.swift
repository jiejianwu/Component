//
//  UIView+Extension.swift
//  Component
//
//  Created by 吴杰健 on 17/3/2.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func w_addCornerWithRadius(radius: CGFloat) {
        w_addCornerWithRadius(radius: radius, corners: UIRectCorner.allCorners)
    }
    
    func w_addCornerWithRadius(radius: CGFloat, corners: UIRectCorner) {
        self.image = self.image?.w_addCornerRadius(radi: radius, corners: corners)
    }

    
}
