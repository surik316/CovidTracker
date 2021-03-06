//
//  PresentableProtocol.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController
    func processPush(_ push: [String: Any])
}

extension UIViewController: Presentable {
    func processPush(_ push: [String : Any]) {}
    func toPresent() -> UIViewController { return self }
}
