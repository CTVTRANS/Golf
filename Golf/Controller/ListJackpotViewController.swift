//
//  ListproductViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var amountJactpot: UILabel!
    @IBOutlet weak var imageJackpot: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func load(_ jackpot: JackpotModel) {
        imageJackpot.kf.setImage(with: URL(string: jackpot.imageURL))
        name.text = jackpot.name
        amountJactpot.text = jackpot.amount.description
    }
}

class ProductScanedCell: UITableViewCell {
    
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var status: UILabel!
    var product: JackpotModel!
    var callBack:((_ idProduct: JackpotModel) -> Void) = {_ in }
    
    func load(_ jackpotScaned: JackpotModel) {
        product = jackpotScaned
        nameProduct.text = jackpotScaned.name
        status.text = jackpotScaned.status.description
    }
    
    @IBAction func pressedReward(_ sender: Any) {
        callBack(product)
    }
}

class ListJackpotViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var table: UITableView!
    var statusProduct: TypeJackpotProduct = .all
    var listJackpot = [JackpotModel]()
    var member: MemberModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch statusProduct {
        case .all:
            getAllProduct()
        case .scaned:
            getProductScan()
        }
    }
    
    func getAllProduct() {
        let task = JackpotModel.GetAll()
        dataWithTask(task, onCompeted: { (data) in
            if let array = data as? [JackpotModel] {
                self.listJackpot = array
                self.table.reloadData()
            }
        }) { (_) in
            
        }
    }
    
    func getProductScan() {
        let task = JackpotModel.GetProductScaned(idCard: member.idCard, type: .scaned)
        dataWithTask(task, onCompeted: { (data) in
            if let array = data as? [JackpotModel] {
                self.listJackpot = array
                self.table.reloadData()
            }
        }) { (_) in
            
        }
    }
}

extension ListJackpotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJackpot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if statusProduct == .all {
            return productCell(indexPath: indexPath)
        } else {
            return productScanedCell(indexPath: indexPath)
        }
    }
    
    func productCell(indexPath: IndexPath) -> ProductCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.load(listJackpot[indexPath.row])
        return cell!
    }
    
    func productScanedCell(indexPath: IndexPath) -> ProductScanedCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProductScanedCell", for: indexPath) as? ProductScanedCell
        cell?.load(listJackpot[indexPath.row])
        cell?.callBack = { [unowned self] (myProduct) in
            if let vc = ResultScanViewController.instance() as? ResultScanViewController {
                vc.product = myProduct
                vc.isHiddenButton = true
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        return cell!
    }
}
