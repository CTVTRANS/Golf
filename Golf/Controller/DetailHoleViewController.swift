//
//  DetailHoleViewController.swift
//  Golf
//
//  Created by le kien on 11/22/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class DetailHoleViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageBackGround: UIImageView!
    @IBOutlet weak var imageMapHole: UIImageView!
    @IBOutlet weak var indexHole: UILabel!
    @IBOutlet weak var detailHole: UIWebView!
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        detailHole.delegate = self
        if index == 17 {
            contentView.isHidden = true
            imageBackGround.image = #imageLiteral(resourceName: "ic_background_hole_17")
            return
        }
        indexHole.text = index.description
        imageBackGround.image = #imageLiteral(resourceName: "ic_backGround_hole")
        imageMapHole.image = UIImage(named: "hole\(index)")
    }
    
    func getDetailHole() {
        let task = HoleModel.GetDetail(index: index)
        dataWithTask(task, onCompeted: { (data) in
            guard let hole = data as? HoleModel else {
                return
            }
            self.detailHole.loadHTMLString(hole.content, baseURL: nil)
        }) { (_) in
            
        }
    }
}

extension DetailHoleViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
