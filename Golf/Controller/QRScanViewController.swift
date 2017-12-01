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
    var product: JackpotModel?
    
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
        
        QRMetadataManager.shared.resultScan = {[unowned self] metadataObjects in
            guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
                return
            }
            let barCodeObject = self.previewLayer?.transformedMetadataObject(for: metadataObj)
            self.qrCodeFrameView.frame = barCodeObject!.bounds
            self.qrCodeFrameView.superview?.bringSubview(toFront: self.qrCodeFrameView)
            if let resultString = metadataObj.stringValue {
                QRMetadataManager.shared.stopScan()
                self.checkProduct(qrID: resultString)
            }
        }
    }
    
    func checkProduct(qrID: String) {
        //call api check product
        showResult()
    }
    
    func showResult() {
        if let vc = ResultScanViewController.instance() as? ResultScanViewController {
            vc.product = self.product
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer?.frame = self.scannerPreview.layer.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.qrCodeFrameView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        QRMetadataManager.shared.startScan()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
