//
//  Coordinator.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
enum FlowResult<R> {
    case success(R)
    case failure(Error)
    case canceled
}

struct CoordinatorConstants {

    struct Push {
        static let screen = "SCREEN"
    }
}

protocol Coordinator: Presentable {

    associatedtype Result

    var result: ((FlowResult<Result>) -> Void)? {get set}

    func start()

}
