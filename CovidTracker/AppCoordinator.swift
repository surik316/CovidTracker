//
//  MainCoordinator.swift
//  CovidTracker
//
//  Created by maksim.surkov on 23.10.2021.
//

import UIKit
import AVFoundation

class AppCoordinator: Coordinator {
    var result: ((FlowResult<Void>) -> Void)?
    
    func presentProLanding() {
        
    }
    
    typealias Result = Void
    
    let router: DefaultRouter = DefaultRouter(with: nil)
    init() {
        (router.toPresent() as? UINavigationController)?.setNavigationBarHidden(true, animated: false)
        start()
    }
    func start() {
        let module = MainPageVC()
        module.viewModel = MainPageViewModel()
        router.setRootModule(module)
    }
    func toPresent() -> UIViewController {
        return router.toPresent()
    }
    
    func presentScreen(_ identifier: String) {

        if let screen = ScreenIdentifier(rawValue: identifier) {

            switch screen {
            default:
                break
            }

        }
    }
    
    func processPush(_ push: [String: Any]) {
        
        if let modalModule = router.modules.filter({ (kind) -> Bool in
            switch kind {
            case .modal:
                return true
            default:
                return false
            }
        }).last {
            
            switch modalModule {
            case .modal(let module):
                module.processPush(push)
            default:
                break
            }
            
        } else if let screenID = push[CoordinatorConstants.Push.screen] as? String {
            presentScreen(screenID)
        }
        
    }
    

}
