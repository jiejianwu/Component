//
//  File.swift
//  Component
//
//  Created by 吴杰健 on 17/3/10.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

extension UIImage {
    
    func w_addCornerRadius(radi: CGFloat) -> UIImage? {
        return self.w_addCornerRadius(radi: radi, corners: .allCorners)
    }
    
    func w_addCornerRadius(radi: CGFloat, corners: UIRectCorner) -> UIImage? {
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radi, height: radi))
        ctx.addPath(path.cgPath)
        ctx.clip()
        self.draw(in: rect)
        ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        defer {
            UIGraphicsEndImageContext()
        }
        return UIGraphicsGetImageFromCurrentImageContext()
        
        
    }
    
}
