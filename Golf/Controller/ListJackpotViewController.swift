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
        amountJactpot.text = "共\(jackpot.amount.description)名"
    }
}

class ProductScanedCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var status: UILabel!
    var product: JackpotModel!
    var callBack:((_ idProduct: JackpotModel) -> Void) = {_ in }
    
    func load(_ jackpotScaned: JackpotModel) {
        product = jackpotScaned
        nameProduct.text = jackpotScaned.name
        status.text = jackpotScaned.statusReward.decodeError()
        if jackpotScaned.isWinings == .notWining {
            button.isEnabled = false
            button.backgroundColor = UIColor.gray
        } else {
            button.isEnabled = true
            button.backgroundColor = UIColor.hex(rgbValue: 0x7AC1A0)
        }
    }
    
    @IBAction func pressedReward(_ sender: Any) {
        callBack(product)
    }
}

class ListJackpotViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var table: UITableView!
    var statusProduct: TypeJackpotProduct = .all
    var listJackpot = [JackpotModel]()
    var member: MemberModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch statusProduct {
        case .all:
            showDescription.isHidden = true
            name.text = "獎品目錄"
            getAllProduct()
        case .scaned:
            name.text = "管理票券"
            showDescription.isHidden = false
            getProductScan()
        }
    }
    
    func getAllProduct() {
        let task = JackpotModel.GetAll()
        dataWithTask(task, onCompeted: { (data) in
            if let array = data as? [JackpotModel] {
                self.listJackpot = array
                self.table.reloadData()
                hideLoading()
            }
        }) { (_) in
            
        }
    }
    
    func getProductScan() {
        let task = JackpotModel.GetProductScaned()
        dataWithTask(task, onCompeted: { (data) in
            if let array = data as? [JackpotModel] {
                self.listJackpot = array
                self.table.reloadData()
                hideLoading()
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
