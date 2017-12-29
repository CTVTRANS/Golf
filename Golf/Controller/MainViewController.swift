//
//  ViewController.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var table: UITableView!
    fileprivate var page = 1
    fileprivate var listNews = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNews()
    }

    
    func getNews() {
        let task = NewsModel.GetList(pager: page)
        dataWithTask(task, onCompeted: { (data) in
            guard let arrNews = data as? [NewsModel] else {
                return
            }
            self.listNews = arrNews
            self.table.reloadData()
        }) { (_) in
        }
    }
    
    // MARK: Action control
    
    @IBAction func pressedAboutUs(_ sender: Any) {
        if let vc = AboutUsViewController.instance() as? AboutUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedContact(_ sender: Any) {
        if let vc = ContactUsViewController.instance() as? ContactUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedEvent(_ sender: Any) {
        if let vc = EventViewController.instance() as? EventViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedDiscount(_ sender: Any) {
        if let vc = DiscountViewController.instance() as? DiscountViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedAttendance(_ sender: Any) {
        if checkMember() != nil, let vc = AttendanceViewController.instance() as? AttendanceViewController {
            navigationController?.pushViewController(vc, animated: false)
            return
        }
        UIAlertController.showAlertWith(title: "", message: "要先登入", in: self, compeletionHandler: {
            if let vc = SinginViewController.instance() as? SinginViewController {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        })
    }
    
    @IBAction func pressedJackpot(_ sender: Any) {
        if checkMember() != nil, let vc = JackpotViewController.instance() as? JackpotViewController {
            navigationController?.pushViewController(vc, animated: false)
            return
        }
        UIAlertController.showAlertWith(title: "", message: "要先登入", in: self, compeletionHandler: {
            if let vc = SinginViewController.instance() as? SinginViewController {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as? NewsViewCell
        cell?.loadNews(listNews[indexPath.row], at: indexPath.row + 1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsModel = listNews[indexPath.row]
        if let vc = NewsDetailViewController.instance() as? NewsDetailViewController {
            vc.news = newsModel
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
