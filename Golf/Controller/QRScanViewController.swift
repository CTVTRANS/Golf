//
//  QRScanViewController.swift
//  Golf
//
//  Created by le kien on 11/27/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var scannerPreview: UIView!
    
    fileprivate lazy var qrCodeFrameView: UIView = {
        let qrView = UIView()
        qrView.layer.borderColor = UIColor.green.cgColor
        qrView.layer.borderWidth = 3
        self.scannerPreview.addSubview(qrView)
        return qrView
    }()
    
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer? {
        didSet {
            if let previewLayer = self.previewLayer {
                self.scannerPreview.layer.addSublayer(previewLayer)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannerPreview.layoutSubviews()
        QRMetadataManager.shared.startScan()
        previewLayer = QRMetadataManager.shared.previewLayer
        
        QRMetadataManager.shared.resultScan = {[weak self] metadataObjects in
            if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                let barCodeObject = self?.previewLayer?.transformedMetadataObject(for: metadataObj)
                self?.qrCodeFrameView.frame = barCodeObject!.bounds
                self?.qrCodeFrameView.superview?.bringSubview(toFront: (self?.qrCodeFrameView)!)
                if let resultString = metadataObj.stringValue {
                    // send id product to server
                    
                    
                    QRMetadataManager.shared.stopScan()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer?.frame = self.scannerPreview.layer.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
