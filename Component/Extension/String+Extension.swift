//
//  String+Extension.swift
//  Component
//
//  Created by 吴杰健 on 17/3/14.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

extension String {
    
    func w_qrUIImage(imageSize: CGSize) -> UIImage? {

        guard let ciImage = self.w_qrCIImage() else {
            return nil
        }
        
        return UIImage.w_creatUIImage(with: ciImage, size: imageSize)
    }
    
    
    func w_qrCIImage() -> CIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = self.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        return filter?.outputImage

    }
    
}
