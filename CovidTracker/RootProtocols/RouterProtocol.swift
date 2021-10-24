//
//  RouterProtocol.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
protocol RouterProtocol: Presentable {

    func present(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable, animated: Bool)
    func setRootModule(_ module: Presentable)
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
    func insert(module: Presentable, at index: Int)
    func firstModule() -> Presentable?
    func lastModule() -> Presentable?

}

extension RouterProtocol {
    func present(_ module: Presentable, animated: Bool) {
        present(module, animated: animated, completion: nil)
    }
}
