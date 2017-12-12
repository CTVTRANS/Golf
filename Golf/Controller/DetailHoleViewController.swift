//
//  DetailHoleViewController.swift
//  Golf
//
//  Created by le kien on 11/22/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class DetailHoleViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var imageDonors: UIImageView!
    @IBOutlet weak var par: UILabel!
    @IBOutlet weak var regularRed: UILabel!
    @IBOutlet weak var regularWhite: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageBackGround: UIImageView!
    @IBOutlet weak var imageMapHole: UIImageView!
    @IBOutlet weak var indexHole: UILabel!
    @IBOutlet weak var detailHole: UIWebView!
    
    var hole: HoleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        detailHole.scrollView.showsVerticalScrollIndicator = false
        if hole.index == 17 {
            contentView.isHidden = true
            imageBackGround.image = #imageLiteral(resourceName: "ic_background_hole_17")
            hideLoading()
            return
        }
        par.text = hole.par.description
        regularRed.text = "Regular(Red)\(hole.regularRed.description)"
        regularWhite.text = "Regular(White)\(hole.regularWhite.description)"
        detailHole.delegate = self
        indexHole.text = hole.index.description
        imageBackGround.image = #imageLiteral(resourceName: "ic_backGround_hole")
        imageMapHole.image = UIImage(named: "hole\(hole.index)")
        imageDonors.kf.setImage(with: URL(string: hole.imageBusiness))
        detailHole.loadHTMLString(hole.content, baseURL: nil)
    }
}

extension DetailHoleViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
