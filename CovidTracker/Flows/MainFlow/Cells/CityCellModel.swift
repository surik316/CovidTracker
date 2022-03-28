//
//  CityCellModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation

struct CityCellModel: SimpleCellViewModel {
    let date: String
    let todayCovidCases: Int
    let theDayBeforeCovidCases: Int
    let totalCovidCases: Int
    let recoveredCovidCases: Int
    let activeCovidCases: Int
    let deathCovidCases: Int
    let last14DaysCases: [Int]
}
