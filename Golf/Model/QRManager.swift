//
//  QRManager.swift
//  Golf
//
//  Created by le kien on 11/27/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import AVFoundation

class QRMetadataManager: NSObject {
    
    var resultScan:((_ data: [AVMetadataObject]) -> Void) = {_ in}
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr
                            ]
    
    static let shared = QRMetadataManager()
    fileprivate var _previewLayer: AVCaptureVideoPreviewLayer?
    lazy var captureSession: AVCaptureSession? = {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            return nil
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            return nil
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
        
        // Initialize the video preview layer
        _previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        _previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return captureSession
    }()
    
    var previewLayer: AVCaptureVideoPreviewLayer? {
        return self._previewLayer
    }
    
    func startScan() {
        if let captureSession = self.captureSession, !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopScan() {
        if let captureSession = self.captureSession, captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension QRMetadataManager: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.first != nil {
            resultScan(metadataObjects)
        }
    }
    
}
