//
//  StateInfoModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation

struct StateModel: Codable {
    let state: String
    let cases, todayCases, deaths, todayDeaths: Int
    let active, tests, testsPerOneMillion: Int
}
