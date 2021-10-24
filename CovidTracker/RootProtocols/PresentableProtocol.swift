//
//  PresentableProtocol.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
import UIKit

protocol Presentable: class {
    func toPresent() -> UIViewController
    
    func presentScreen(_ identifier: String)
    func processPush(_ push: [String: Any])
}

extension UIViewController: Presentable {
    
    func presentScreen(_ identifier: String) {
        
    }
    
    func processPush(_ push: [String : Any]) {
        
    }
    
    func toPresent() -> UIViewController {
        return self
    }
}
