//
//  ResultScanViewController.swift
//  Golf
//
//  Created by le kien on 11/28/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ResultScanViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var nameProduct2: UILabel!
    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var titleWinings: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var imageResult: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var product: ProductJackpotModel?
    var isHiddenButton = false
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
        button.isHidden = isHiddenButton
        nameProduct2.isHidden = !isHiddenButton
        showResult()
    }
    
    func showResult() {
        if isHiddenButton &&  product != nil {
            nameProduct2.text = product?.name
            productID.text = "會員: \(MemberModel.shared.name)"
            nameProduct.text = product?.productCode
            titleWinings.isHidden = true
            imageProduct.kf.setImage(with: URL(string: (product?.imageURL)!))
            imageResult.image = #imageLiteral(resourceName: "ic_jackpot_winnings")
        } else if !isHiddenButton && product != nil {
            productID.text = product?.productCode
            nameProduct.text = product?.name
            imageProduct.kf.setImage(with: URL(string: (product?.imageURL)!))
            imageResult.image = #imageLiteral(resourceName: "ic_jackpot_winnings")
        } else {
            productID.isHidden = true
            titleWinings.isHidden = true
            nameProduct.isHidden = true
            imageProduct.isHidden = true
            imageResult.image = #imageLiteral(resourceName: "ic_jackpot_failure")
            if message != "" {
                UIAlertController.showAlertWith(title: "", message: message, in: self)
            }
        }
        hideLoading()
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        if checkMember() != nil, let vc = ListJackpotViewController.instance() as? ListJackpotViewController {
            vc.statusProduct = .scaned
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
