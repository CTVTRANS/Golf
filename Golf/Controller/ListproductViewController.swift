//
//  ListproductViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
enum TypeShowProduct: Int {
    case all = 0, scaned
}

class ProductCell: UITableViewCell {
    
}

class ListproductViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var table: UITableView!
    var statusProduct: TypeShowProduct = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
    }
}

extension ListproductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
