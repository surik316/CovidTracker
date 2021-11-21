//
//  API.swift
//  CovidTracker
//
//  Created by maksim.surkov on 21.11.2021.
//

import Foundation

protocol EndPoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
struct CountryInfoModel: Codable {
    let updated: Int
    let country: String
    let countryInfo: Flag
    let cases, todayCases, deaths, todayDeaths: Int
    let recovered, todayRecovered, active, critical: Int
    let tests, population: Int
}

// MARK: - CountryInfo
struct Flag: Codable {
    let flag: String
}

enum CoronaEndPoint: EndPoint {
    case getCountryData(name: String)
    case getStateData(name: String)
    case getWorldData
    case getOtherCountriesData
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "corona.lmao.ninja"
        }
    }
    var path: String {
        switch self {
        case .getCountryData(let name):
            return "/v2/countries/\(name)"
        case .getStateData(let name):
            return "/v2/states/\(name)"
        case .getWorldData:
            return "/v2/all"
        case .getOtherCountriesData:
            return "/v2/countries"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .getCountryData:
            return [URLQueryItem(name: "yesterday", value: nil),
                    URLQueryItem(name: "strict", value: nil),
                    URLQueryItem(name: "query%20", value: nil)]
        case .getStateData, .getWorldData:
            return [URLQueryItem(name: "yesterday", value: nil)]
        case .getOtherCountriesData:
            return [URLQueryItem(name: "yesterday", value: nil),
                    URLQueryItem(name: "sort", value: nil)]
        }
    }
    
    var method: String {
        switch self {
        case .getCountryData, .getStateData,.getWorldData, .getOtherCountriesData:
            return "GET"
        }
    }
}

class NetworkEngine {
    class func request<T: Codable>(endpoint: EndPoint, completion: @escaping(Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
                    completion(.failure(error))
                }
            }

        }
        dataTask.resume()
    }
}
