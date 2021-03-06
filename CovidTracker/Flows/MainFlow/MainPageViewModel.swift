//
//  MainPageViewModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 29.10.2021.
//

import Foundation

class MainPageViewModel {
    
    private(set) var countryData: CountryInfoModel!
    private(set) var stateData: StateModel!
    private(set) var otherCountriesData: [CountryInfoModel]!
    private(set) var worldData: WorldModel!
    
    init() {
    }
    func getCountryData(name: String) {
//        NetworkEngine.request(endpoint: CoronaEndPoint.getCountryData(name: name)) { (result: Result<CountryInfoModel, Error>) in
//            switch result {
//            case .success(let response):
//                self.countryData = response
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
//        NetworkEngine.request(endpoint: CoronaEndPoint.getStateData(name: "Washington")) { (result: Result<StateModel, Error>) in
//            switch result {
//            case .success(let response):
//                self.stateData = response
//            case .failure(let error):
//                print(error)
//            }
//        }
//        NetworkEngine.request(endpoint: CoronaEndPoint.getOtherCountriesData) { (result: Result<[CountryInfoModel], Error>) in
//            switch result {
//            case .success(let response):
//                self.otherCountriesData = response
//            case .failure(let error):
//                print(error)
//            }
//        }
        NetworkEngine.request(endpoint: CoronaEndPoint.getWorldData) { (result: Result<WorldModel, Error>) in
            switch result {
            case .success(let response):
                self.worldData = response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getStateData(name: String) {
        NetworkEngine.request(endpoint: CoronaEndPoint.getCountryData(name: name)) { (result: Result<CountryInfoModel, Error>) in
            switch result {
            case .success(let response):
                self.countryData = response
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
