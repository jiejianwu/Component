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
    
    static func w_creatUIImage(with ciImage: CIImage, size: CGSize) -> UIImage {
        let rect = ciImage.extent
        let scaleX = size.width / rect.width
        let scaleY = size.height / rect.height
        
        let ciImageTransform = ciImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        return UIImage(ciImage: ciImageTransform)
        
//        let cs = CGColorSpaceCreateDeviceGray()
//        let bitmapRef = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGBitmapInfo(rawValue: CGBitmapInfo.byteOrderMask.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue).rawValue)
//        let context = CIContext()
//        guard let cgImage = context.createCGImage(ciImage, from: rect) else {
//            return nil
//        }
//        
//        bitmapRef?.interpolationQuality = CGInterpolationQuality.none
//        bitmapRef?.draw(cgImage, in: rect)
//        guard let scaledImage = bitmapRef?.makeImage() else {
//            return nil
//        }
//        return UIImage(cgImage: scaledIm
    }
}
