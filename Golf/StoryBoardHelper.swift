//
//  StoryBoardHelper.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

protocol StoryBoardHelper {
    static func instance() -> UIViewController
}

protocol MainStoryBoard: StoryBoardHelper {}
extension MainStoryBoard {
    static func instance() -> UIViewController {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        return myStoryBoard.instantiateViewController(withIdentifier: String(describing: self.self))
    }
}

protocol SecondSroyBoard: StoryBoardHelper {}
extension SecondSroyBoard {
    static func instance() -> UIViewController {
        let myStoryBoard = UIStoryboard(name: "Second", bundle: nil)
        return myStoryBoard.instantiateViewController(withIdentifier: String(describing: self.self))
    }
}
