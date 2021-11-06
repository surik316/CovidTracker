//
//  TabsRouter.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
import UIKit

class TabsRouter: Presentable {

    private var modules: [Presentable] = []
    private(set) var tabs: [Presentable]
    let container = UITabBarController()

    init(with items: [Presentable]) {
        self.tabs = items
        self.container.viewControllers = items.map {$0.toPresent()}
        configure()
    }

    private func configure() {
        container.tabBar.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        //container.tabBar.barStyle = .black
        //container.tabBar.barTintColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        //container.tabBar.isTranslucent = false
        container.tabBar.tintColor = .white
    }

    func toPresent() -> UIViewController {
        return self.container
    }

    func present(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        container.present(module.toPresent(), animated: animated, completion: completion)
        modules.append(module)
    }

    func setRootModules(_ modules: [Presentable]) {
        self.tabs = modules
        container.viewControllers = modules.map {$0.toPresent()}
    }

    func popModule(animated: Bool) {
        if let module = modules.last {
            module.toPresent().dismiss(animated: animated, completion: nil)
            self.modules.removeLast()
        }
    }

    func insert(module: Presentable, at index: Int) {
        var viewControllers = container.viewControllers
        viewControllers?.insert(module.toPresent(), at: index)
        container.viewControllers = viewControllers
        tabs.insert(module, at: index)
    }

    func lastModule() -> Presentable? {
        return modules.last ?? container
    }

    func presentScreen(_ identifier: String) {}
    func processPush(_ push: [String: Any]) {}
}
