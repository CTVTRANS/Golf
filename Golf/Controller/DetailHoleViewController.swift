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
    @IBOutlet weak var indexHole: UILabel!
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        indexHole.text = index?.description
        if index == 17 {
            contentView.isHidden = true
            imageBackGround.image = #imageLiteral(resourceName: "ic_background_hole_17")
        } else {
            imageBackGround.image = #imageLiteral(resourceName: "ic_backGround_hole")
        }
    }
}
