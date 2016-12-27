//
//  RatingView.swift
//  GreenDoctor
//
//  Created by 吴杰健 on 15/12/22.
//  Copyright © 2015年 kangkanghui. All rights reserved.
//

import UIKit

enum RatingModel {
    
    case Integer, Half, Float

}

class RatingView: UIView {
    
    var ratingModel: RatingModel = .Integer
    fileprivate var _wToHRate: CGFloat = 1
    fileprivate let _selectLayer = CALayer()
    fileprivate var _napWidth: CGFloat = 0
    fileprivate var _value: Float = 0 {
        didSet {
            self.setHeartByValue()
        }
    }
    fileprivate var _imageWidth: CGFloat = 0
    fileprivate var _widthEnough: Bool = true
    var value: Float {
        set {
            
            guard newValue >= 0 && newValue <= 5 else {
                return
            }
            switch ratingModel {
            case .Integer:
                let tmp = Int(newValue)
                _value = Float(tmp + (newValue > Float(tmp) ? 1 : 0))
            case .Half:
                let tmp = Int(newValue / 0.5)
                _value = Float(Int(newValue / 0.5) + (newValue * 2 > Float(tmp)  ? 1 : 0)) * 0.5
            default:
                _value = newValue
            }
        }
        get {
            return _value
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _refreshUI()
    }
    
    func setup(imageName: String, selectedImageName sImageName: String, touchEnable: Bool){
        
        guard let image = UIImage(named: imageName), let sImage = UIImage(named: sImageName) else {
            return
        }
        
        _wToHRate = image.size.width / image.size.height
        
        for layer in self.layer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        
        for layer in _selectLayer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        
        (0...4).forEach {_ in
            let lay = CALayer()
            lay.contents = image.cgImage
            self.layer.addSublayer(lay)
            let sLay = CALayer()
            sLay.contents = sImage.cgImage
            self._selectLayer.addSublayer(sLay)
        }
        
        self.layer.addSublayer(_selectLayer)
        _selectLayer.frame = self.bounds
        _selectLayer.masksToBounds = true
        _refreshUI()
    
        if touchEnable {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(changeValue(gesture:)))
            self.addGestureRecognizer(gesture)
        }
    }
    
    fileprivate func _reCalculate() {
        let imageWidth = self.frame.height * _wToHRate
        if imageWidth * 5 <= self.frame.width {
            _imageWidth = imageWidth
            _napWidth = (self.frame.width - imageWidth * 5) / 4
        } else {
            _imageWidth = self.frame.width / 5
            _napWidth = 0
        }
    }
    
    fileprivate func _refreshUI() {
        _reCalculate()
        let block: ((Int, CALayer) -> Void) = {
            $1.frame = CGRect(x: CGFloat($0) * (self._imageWidth + self._napWidth), y: 0, width: self._imageWidth, height: self.frame.height)
        }
        (self.layer.sublayers ?? []).filter{ $0 != self._selectLayer }.enumerated().forEach(block)
        (self._selectLayer.sublayers ?? []).enumerated().forEach(block)
        setHeartByValue()
    }
    
    @objc fileprivate func changeValue(gesture: UITapGestureRecognizer){
        let xPoint = gesture.location(in: self).x
        let tmpValue = Int(xPoint / (_imageWidth + _napWidth))
        let leftWidth = xPoint - (_imageWidth + _napWidth) * CGFloat(tmpValue)
        if leftWidth >= _imageWidth {
            value = Float(tmpValue + 1)
        } else {
            value = Float(tmpValue) + Float(leftWidth / _imageWidth)
        }
    }

    fileprivate func setHeartByValue(){
        let int = CGFloat(Int(_value))
        _selectLayer.frame = CGRect(x: 0, y: 0, width:  int * (_imageWidth + _napWidth) + (CGFloat(_value) - int) * _imageWidth, height: self.frame.height)
    }
    
}
