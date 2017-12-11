//
//  ResultScanViewController.swift
//  Golf
//
//  Created by le kien on 11/28/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ResultScanViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var titleWinings: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var imageResult: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var product: JackpotModel?
    var isHiddenButton = false
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
        showResult()
        button.isHidden = isHiddenButton
    }
    
    func showResult() {
        if product != nil {
            productID.text = product?.productCode
            nameProduct.text = product?.name
            nameProduct.isHidden = false
            button.setTitle("show list scaned", for: .normal)
            imageProduct.kf.setImage(with: URL(string: (product?.imageURL)!))
            imageResult.image = #imageLiteral(resourceName: "ic_jackpot_winnings")
        } else {
            productID.isHidden = true
            titleWinings.isHidden = true
            nameProduct.isHidden = true
            button.setTitle("return scan", for: .normal)
            imageProduct.isHidden = true
            imageResult.image = #imageLiteral(resourceName: "ic_jackpot_failure")
            UIAlertController.showAlertWith(title: "", message: message, in: self)
        }
        hideLoading()
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        if product != nil {
            if let member = checkMember(), let vc = ListJackpotViewController.instance() as? ListJackpotViewController {
                vc.statusProduct = .scaned
                vc.member = member
                navigationController?.pushViewController(vc, animated: false)
            }
        } else {
            navigationController?.popViewController(animated: false)
        }
    }
}
