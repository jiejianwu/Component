//
//  QRImageGeneratorViewController.swift
//  Component
//
//  Created by 吴杰健 on 17/3/14.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

class QRImageGeneratorViewController: BaseViewController {
    
    var inputTextField: UITextField?
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
        
    }
    
    private func _init() {
        inputTextField = UITextField()
        inputTextField?.frame.size = CGSize(width: 280, height: 40)
        inputTextField?.center = CGPoint(x: screenWidth / 2, y: 100)
        inputTextField?.textAlignment = .center
        inputTextField?.borderStyle = .roundedRect
        inputTextField?.delegate = self
        view.addSubview(inputTextField!)
        
        imageView = UIImageView()
        imageView?.backgroundColor = UIColor.gray
        imageView?.frame = CGRect(x: screenWidth / 2 - 140, y: inputTextField!.frame.maxY + 50, width: 280, height: 280)
        view.addSubview(imageView!)
        
        
    }
    
}


extension QRImageGeneratorViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            imageView?.image = textField.text?.w_qrUIImage(imageSize: imageView!.frame.size)
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
}
