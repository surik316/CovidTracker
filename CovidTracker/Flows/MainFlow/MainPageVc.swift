//
//  MainPageVc.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

private enum Static {
    static let settingsIcon = UIImage(named: "settings_wheel")
}

class MainPageVC: UIViewController {
    
    
    // MARK: UI элементы

    // MARK: Приватные свойства
    private let bag = DisposeBag()

    // MARK: Публичные свойства
    //var viewModel: MainPageViewModel = .init()
    
    // MARK: override свойства
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: override методы
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
