//
//  AppDelegate.swift
//  CovidTracker
//
//  Created by maksim.surkov on 23.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let appCoordinator: Presentable
    override init() {
        let mainCoordinator = AppCoordinator()
        mainCoordinator.start()
        appCoordinator = TabBarCoordinator(with: [.init(module: mainCoordinator, icon: UIImage(systemName: "scribble")!, title: "MainPage")])
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setup()

        return true
    }
    private func setup() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
        window?.rootViewController = appCoordinator.toPresent()
        window?.makeKeyAndVisible()
    }
}

