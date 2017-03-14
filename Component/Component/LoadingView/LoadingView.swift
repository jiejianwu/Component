//
//  LoadingView.swift
//  Component
//
//  Created by 吴杰健 on 17/2/28.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    var circleWidth: CGFloat = 5
    var circleRadi: CGFloat {
        set {
            _circleRadi = newValue
        }
        get {
            if let radi = _circleRadi {
                return radi
            }
            return min(self.bounds.width, self.bounds.height) / 2 * 0.8
        }
    }
    var circleColor: UIColor = UIColor(red: 0.1, green: 0.6, blue: 0.1, alpha: 1)
    
    private var completed = false
    private var _circleRadi: CGFloat?
    
    private lazy var bgLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        self.layer.addSublayer(lay)
        return lay
    }()

    fileprivate lazy var circleLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        self.layer.addSublayer(lay)
        return lay
    }()
    
    private lazy var checkLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        lay.frame = self.bounds
        self.layer.addSublayer(lay)
        return lay
    }()
    
    
    
    
    
    var selfWidth: CGFloat {
        return self.bounds.width
    }
    
    var selfHeight: CGFloat {
        return self.bounds.height
    }
    
    var circleCenterPoint: CGPoint {
        return CGPoint(x: selfWidth / 2, y: selfHeight / 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if completed {
            setCompleted()
        } else {
            circleLayer.removeAllAnimations()
            setup()
        }
    }
    
    func layoutSubLayer() {
        bgLayer.frame = self.bounds
        checkLayer.frame = self.bounds
        circleLayer.frame = self.bounds
    }
    
    func setup() {
        self.backgroundColor = UIColor.white
        layoutSubLayer()
        drawBgLayer()
        drawCircleLayer()
        addAnimationToCircleLayer()
    }
    
    func setCompleted() {
        layoutSubLayer()
        drawCircleLayer()
        drawCheckLayer()

    }
    
    func drawBgLayer() {
        let bgPath = UIBezierPath(arcCenter: circleCenterPoint, radius: circleRadi, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        bgLayer.path = bgPath.cgPath
        bgLayer.lineWidth = circleWidth;
        bgLayer.strokeColor = UIColor(white: 0.8, alpha: 0.9).cgColor
        bgLayer.fillColor = UIColor.clear.cgColor;
    }
    
    func drawCircleLayer() {
        let path = UIBezierPath(arcCenter: circleCenterPoint, radius: circleRadi, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = circleWidth
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd = 1
    }
    
    func loadingCompleted() {
        if completed { return }
        completed = true
        circleLayer.strokeEnd = 1
        let bAnimation = CABasicAnimation(keyPath:"strokeEnd")
        bAnimation.delegate = self
        bAnimation.duration = 0.5
        bAnimation.fromValue = 1.0 / 4
        bAnimation.toValue = 1
        circleLayer.add(bAnimation, forKey: "loading completed")
        
    }
    
    func drawCheckLayer() {
        
        let path = UIBezierPath()

        let point1Angle = CGFloat(M_PI)
        let point1RateToRadi: CGFloat = 3.0 / 5
        let point2Angle = CGFloat(M_PI) * 3.0 / 5
        let point2RateToRadi: CGFloat = 3.0 / 7
        let point3Angle = -1.0 * CGFloat(M_PI) / 5
        let point3RateToRadi: CGFloat = 2.0 / 3
        
        let point1 = CGPoint(x: self.circleCenterPoint.x + self.circleRadi * point1RateToRadi * cos(point1Angle), y: self.circleCenterPoint.y + self.circleRadi * point1RateToRadi * sin(point1Angle))
        path.move(to: point1)
        
        let point2 = CGPoint(x: self.circleCenterPoint.x + self.circleRadi * point2RateToRadi * cos(point2Angle), y: self.circleCenterPoint.y + self.circleRadi * point2RateToRadi * sin(point2Angle))
        path.addLine(to: point2)
        
        let point3 = CGPoint(x: self.circleCenterPoint.x + self.circleRadi * point3RateToRadi * cos(point3Angle), y: self.circleCenterPoint.y + self.circleRadi * point3RateToRadi * sin(point3Angle))
        path.addLine(to: point3)

        checkLayer.path = path.cgPath
        checkLayer.strokeColor = self.circleColor.cgColor
        checkLayer.lineWidth = self.circleWidth
        checkLayer.fillColor = nil
        checkLayer.strokeEnd = 1.0

    }
    
    func addAnimationToCheckLayer() {
        
        let bAnimation = CABasicAnimation(keyPath: "strokeEnd")
        bAnimation.duration = 0.2
        bAnimation.fromValue = 0
        bAnimation.toValue = 1
        checkLayer.add(bAnimation, forKey: "check Animation")
    }
    
    func addAnimationToCircleLayer() {
        let bAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        bAnimation.repeatCount = MAXFLOAT
        bAnimation.duration = 1
        bAnimation.fromValue = 0
        bAnimation.toValue = 2 * M_PI
        circleLayer.strokeEnd = 1.0 / 4
        circleLayer.add(bAnimation, forKey: "rotation animation")

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
}

extension LoadingView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        circleLayer.removeAllAnimations()
        drawCheckLayer()
        addAnimationToCheckLayer()
    }
    
    
}
