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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib.init(nibName: "HoleViewCell", bundle: nil), forCellWithReuseIdentifier: "HoleViewCell")
    }
    
}

extension HoleListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "HoleViewCell", for: indexPath) as? HoleViewCell
        cell?.indexHole.text = String(indexPath.row + 1)
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
            vc.index = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
