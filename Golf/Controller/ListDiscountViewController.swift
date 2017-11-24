//
//  ListDiscountViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

enum TypeDiscount: Int {
    case product = 0, store
}

class DiscountCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageDiscount: UIImageView!
    
    func load(_ discount: DiscountModel) {
        price.text = discount.price.description
        name.text = discount.name
        imageDiscount.kf.setImage(with: URL(string: discount.imageURL))
    }
}

class ListDiscountViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var table: UITableView!
    var typeDiscount: TypeDiscount = .product
    var listDiscount = [DiscountModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if typeDiscount == .product {
            name.text = "球場優惠資訊"
        } else {
            name.text = "廠商優惠資訊"
        }
    }
}

extension ListDiscountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDiscount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as? DiscountCell
        cell?.load(listDiscount[indexPath.row])
        return cell!
    }
}
