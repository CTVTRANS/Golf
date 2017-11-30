//
//  ResultScanViewController.swift
//  Golf
//
//  Created by le kien on 11/28/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ResultScanViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var imageResult: UIImageView!
    var resutl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        if resutl != "" {
            imageResult.kf.setImage(with: URL(string: "http://cdn.newsapi.com.au/image/v1/85fb305132eb20ebbb01af386983c8a1"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (_, _, _, _) in
                hideLoading()
            })
        }
    }
}
