//
//  EndPointProtocol.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation

protocol EndPoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
