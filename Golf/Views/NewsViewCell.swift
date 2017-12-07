//
//  TableViewCell.swift
//  Golf
//
//  Created by le kien on 12/7/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var indexNews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadNews(_ news: NewsModel, at index: Int) {
        titleNews.text = news.titleNews
        indexNews.text = index.description + "."
    }
}
