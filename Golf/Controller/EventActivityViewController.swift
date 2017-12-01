//
//  Event_ActivityViewController.swift
//  Golf
//
//  Created by le kien on 12/1/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class EventActivityViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var contentAvtivityView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var timeAttend: UILabel!
    @IBOutlet weak var priceAttend: UILabel!
    @IBOutlet weak var listEvent: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var typeShow: TypeShow = .company
    var event: EventActivityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch typeShow {
        case .company:
            backgroundImage.image = #imageLiteral(resourceName: "ic_info_company")
            contentAvtivityView.isHidden = true
            titleView.text = "公益夥伴"
        case .activity:
            backgroundImage.image = #imageLiteral(resourceName: "ic_background")
            contentAvtivityView.isHidden = false
            titleView.text = "活動內容"
        default:
            break
        }
    }
    
    func getEvetn() {
        setupUI()
    }
    
    func setupUI() {
        time.text = event?.time
        address.text = event?.address
        timeAttend.text = event?.timeAttend
        priceAttend.text = event?.priceAttend.description
        var nameEvent = ""
        for activity in (event?.listActivity)! {
            nameEvent += "\(activity.time)  \(activity.content)\n"
        }
        listEvent.text = nameEvent
        descriptionLabel.text = event?.description
    }

}
