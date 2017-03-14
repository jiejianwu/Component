//
//  QRScanViewController.swift
//  Component
//
//  Created by 吴杰健 on 17/3/13.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanViewController: BaseViewController {
    
    var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var shadowLayer: CAShapeLayer?
    
    var scanRect = CGRect(x: 0.2, y: 0.3, width: 0.6, height: 0.5)
    //if success is true, String is the result, when false, String is the error message
    var scanHandler: ((Bool, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    private func _init() {
        do {
            device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            input = try AVCaptureDeviceInput(device: device)
            output = AVCaptureMetadataOutput()
            output?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output?.rectOfInterest = scanRect
            session = AVCaptureSession()
            if let s = session {
                if s.canAddInput(input) {
                    s.addInput(input)
                }
                if s.canAddOutput(output) {
                    s.addOutput(output)
                }
            }
            output?.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.frame = view.bounds
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            view.layer.addSublayer(previewLayer!)
            
            _initMask()
            
            session?.startRunning()
        } catch {
            scanHandler?(false, error.localizedDescription)
        }

    }
    
    private func _initMask() {
        let bPath = UIBezierPath()
        bPath.lineCapStyle = .square
        bPath.lineJoinStyle = .miter
        
        let topWidth = scanRect.origin.y * screenHeight
        let buttomWidth = (1 - scanRect.origin.y - scanRect.height) * screenHeight
        let leftWidth = scanRect.origin.x * screenWidth
        let rightWidth = (1 - scanRect.origin.x - scanRect.width) * screenWidth
        let width = max(topWidth, buttomWidth, leftWidth, rightWidth)
        print(topWidth, buttomWidth, leftWidth, rightWidth, width)
        bPath.move(to: CGPoint(x: leftWidth - width / 2, y: topWidth - width / 2))
        bPath.addLine(to: CGPoint(x: screenWidth - rightWidth + width / 2, y: topWidth - width / 2))
        bPath.addLine(to: CGPoint(x: screenWidth - rightWidth + width / 2, y: screenHeight - buttomWidth + width / 2))
        bPath.addLine(to: CGPoint(x: leftWidth - width / 2, y: screenHeight - buttomWidth + width / 2))
        bPath.close()
        
        shadowLayer = CAShapeLayer()
        shadowLayer?.frame = view.bounds
        shadowLayer?.path = bPath.cgPath
        shadowLayer?.lineWidth = width
        shadowLayer?.strokeColor = UIColor(white: 0.5, alpha: 0.3).cgColor
        shadowLayer?.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shadowLayer!)
    }
    
}


extension QRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        guard let obj = metadataObjects.last as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        session?.stopRunning()
        previewLayer?.removeFromSuperlayer()
        shadowLayer?.removeFromSuperlayer()
        print(obj.stringValue)
        scanHandler?(false, obj.stringValue)

    }
    
}
