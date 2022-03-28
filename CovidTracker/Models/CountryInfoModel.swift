//
//  CountryInfoModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation

struct CountryInfoModel: Codable {
    let updated: Int
    let country: String
    //let countryInfo: Flag
    let cases, todayCases, deaths, todayDeaths: Int
    let recovered, todayRecovered, active, critical: Int
    let tests, population: Int
}

// MARK: - CountryInfo
struct Flag: Codable {
    let flag: String
}
