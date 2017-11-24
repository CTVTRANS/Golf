//
//  ListproductViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
enum TypeJackpotProduct: Int {
    case all = 0, scaned
}

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var amountJactpot: UILabel!
    @IBOutlet weak var imageJackpot: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    
    func load(_ jackpot: JackpotModel, _ type: TypeJackpotProduct) {
        imageJackpot.kf.setImage(with: URL(string: jackpot.imageURL))
        name.text = jackpot.name
        if type == .all {
            amountJactpot.text = jackpot.amount.description
            status.isHidden = true
            imageJackpot.isHidden = false
        } else {
            amountJactpot.text = "XYZ"
            status.text = jackpot.amount.description
            status.isHidden = false
            imageJackpot.isHidden = true
        }
    }
}

class ListJackpotViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var table: UITableView!
    var statusProduct: TypeJackpotProduct = .all
    var listJackpot = [JackpotModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
    }
}

extension ListJackpotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJackpot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.load(listJackpot[indexPath.row], statusProduct)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
