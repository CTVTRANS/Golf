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
    @IBOutlet weak var contentActivityView: UIScrollView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var timeAttend: UILabel!
    @IBOutlet weak var priceAttend: UILabel!
    @IBOutlet weak var listEvent: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var typeShow: TypeShow = .company
    private var event: EventActivityModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch typeShow {
        case .company:  // show image of donors
            backgroundImage.image = #imageLiteral(resourceName: "ic_info_company")
            contentActivityView.isHidden = true
            titleView.text = "公益夥伴"
            hideLoading()
        case .activity: // show activity
            backgroundImage.image = #imageLiteral(resourceName: "ic_background")
            contentActivityView.isHidden = false
            titleView.text = "活動內容"
            getEvent()
        default:
            break
        }
    }
    
    func getEvent() {
        let task = EventActivityModel.GetActivityInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let eventModel = data as? EventActivityModel else {
                return
            }
            self.event = eventModel
            self.setupUI()
        }) { (_) in
        }
    }
    
    func setupUI() {
        time.text = event?.time
        address.text = event?.address
        timeAttend.text = event?.timeAttend
        priceAttend.text = event?.priceAttend.description
        var listActivity = ""
        for actitity in event.listActivity {
            listActivity += "\(actitity.time)\t\(actitity.content)\n"
        }
        listEvent.text = listActivity
        descriptionLabel.text = event?.description
        hideLoading()
    }

}
