//
//  Extension+Activity.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

func showLoading() {
    let viewLoading = LKActivity.showLoadingWithTitle(title: "Loading")
    UIApplication.shared.keyWindow?.addSubview(viewLoading)
}

func hideLoading() {
    DispatchQueue.main.async {
        let windown = UIApplication.shared.keyWindow
        let views = windown?.subviews
        for view in views! where view is LKActivity {
            view.removeFromSuperview()
        }
    }
}

class LKActivity: UIView {
    
    static func showLoadingWithTitle(title: String) -> LKActivity {
        let backgroundView = LKActivity(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, apla: 0.5)
        
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        loadingView.backgroundColor = .black
        loadingView.layer.cornerRadius = 8
        loadingView.clipsToBounds = true
        backgroundView.addSubview(loadingView)
        loadingView.center = backgroundView.center
        
        let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activity.activityIndicatorViewStyle = .whiteLarge
        loadingView.addSubview(activity)
        activity.center = CGPoint(x: 50, y: 40)
        activity.startAnimating()
        
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 100, height: 40))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = title
        label.textAlignment = .center
        loadingView.addSubview(label)
        return backgroundView
    }
    
    func hiddeLoadingForView() {
        self.removeFromSuperview()
    }
}
