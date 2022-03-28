//
//  WorldInfoModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation

struct WorldModel: Codable {
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let todayDeaths: Int
}
