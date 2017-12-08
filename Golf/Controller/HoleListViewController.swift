//
//  HoldListViewController.swift
//  Golf
//
//  Created by le kien on 11/22/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class HoleListViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var collection: UICollectionView!
    private var listHole = [HoleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        collection.register(UINib.init(nibName: "HoleViewCell", bundle: nil), forCellWithReuseIdentifier: "HoleViewCell")
        getHole()
    }
    
    func getHole() {
        let task = HoleModel.GetDetail()
        dataWithTask(task, onCompeted: { (data) in
            guard let array = data as? [HoleModel] else {
                return
            }
            self.listHole = array
            self.collection.reloadData()
            hideLoading()
        }) { (_) in
            
        }
    }
    
}

extension HoleListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listHole.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "HoleViewCell", for: indexPath) as? HoleViewCell
        cell?.indexHole.text = listHole[indexPath.row].index.description
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((widthScreen - 170) / 3)
        return CGSize(width: width, height: width + 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = DetailHoleViewController.instance() as? DetailHoleViewController {
            vc.hole = listHole[indexPath.row]
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
