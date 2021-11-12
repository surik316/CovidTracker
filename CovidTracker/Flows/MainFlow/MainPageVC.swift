//
//  MainPageVc.swift
//  CovidTracker
//
//  Created by maksim.surkov on 24.10.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

private enum Static {
    static let settingsIcon = UIImage(named: "settings_wheel")
}
protocol SimpleCellViewModel {
    
}

extension SubscriptionOption: SimpleCellViewModel {
    
}

struct TextCellViewModel: SimpleCellViewModel {
    let text: String
    let textColor: UIColor
}
struct CityCellViewModel: SimpleCellViewModel {
    let date: String
    let todayCovidCases: Int
    let theDayBeforeCovidCases: Int
    let totalCovidCases: Int
    let recoveredCovidCases: Int
    let activeCovidCases: Int
    let deathCovidCases: Int
    let last14DaysCases: [Int]
}
enum SubscriptionOption {
    case country
    case world
    case restWorld
    case city
    case no
}

class MainPageVC: UIViewController {
    
    
    // MARK: UI элементы
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: Приватные свойства
    private let bag = DisposeBag()

    // MARK: Публичные свойства
    private let countryCellIdentifier = "CountryStatisticsCell"
    private let cityCellIdentifier = "CityStatisticsCell"
    private let worldCellIdentifier = "WorldStatisticsCell"
    private let restWorldCellIdentifier = "RestWorldStatisticsCell"
    var viewModel: MainPageViewModel = .init()
    private lazy var subscriptionOptions: [SimpleCellViewModel] = [
        SubscriptionOption.country,
        SubscriptionOption.city,
        SubscriptionOption.world,
        SubscriptionOption.restWorld,
    ]
    // MARK: override свойства
    
    // MARK: override методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
             } else {
                make.edges.equalToSuperview()
             }
        }
        tableView.register(CountryStatisticsCell.self, forCellReuseIdentifier: countryCellIdentifier)
        tableView.register(CityStatisticsCell.self, forCellReuseIdentifier: cityCellIdentifier)
        tableView.register(WorldStatisticsCell.self, forCellReuseIdentifier: worldCellIdentifier)
        tableView.register(RestWorldStatisticsCell.self, forCellReuseIdentifier: restWorldCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configure() {
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    }
    
    private func setupBindings() {
        
    }
    
}
extension MainPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item  = subscriptionOptions[indexPath.row]
        switch item {
        case SubscriptionOption.country:
            return 430
        case SubscriptionOption.city:
            return 300
        default:
            return 430
        }
    }
}

extension MainPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch subscriptionOptions[indexPath.row] {
        case let option as SubscriptionOption:
            switch option {
            case .country:
                return dequeueCountryCell(at: indexPath)
            case .city:
                return dequeueCityCell(at: indexPath)
            case .world:
                return dequeueWorldCell(at: indexPath)
            case .restWorld:
                return dequeueRestCell(at: indexPath)
            default:
                debugPrint("")
            }
        default:
            assertionFailure("Unhandled type in options")
        }
        return tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier, for: indexPath)
    }
    private func dequeueCountryCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier, for: indexPath) as! CountryStatisticsCell
        let model = CountryStatisticsCell.Model(
            date: "New cases at 10/29/2021",
            todayCovidCases: 39849,
            theDayBeforeCovidCases: 39070,
            totalCovidCases: 8432546,
            recoveredCovidCases: 7302515,
            activeCovidCases: 893811,
            deathCovidCases: 236220,
            last14DaysCases: [5,5,5,5,5,5])
        cell.configure(from: model)
        return cell
    }
    private func dequeueCityCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellIdentifier, for: indexPath) as! CityStatisticsCell
        let model = CityStatisticsCell.Model(
            city: "Moskow",
            todayCovidCases: 171,
            totalCovidCases: 39766,
            recoveredCovidCases: 33603,
            activeCovidCases: 5682,
            deathCovidCases: 481)
        cell.configure(from: model)
        return cell
    }
    private func dequeueWorldCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: worldCellIdentifier, for: indexPath) as! WorldStatisticsCell
        let model = WorldStatisticsCell.Model(
            todayCovidCases: 237563,
            totalCovidCases: 247353512,
            recoveredCovidCases: 33603,
            activeCovidCases: 18302686,
            deathCovidCases: 5013916)
        cell.configure(from: model)
        
        return cell
    }
    private func dequeueRestCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restWorldCellIdentifier, for: indexPath) as! RestWorldStatisticsCell
        
        let model = RestWorldStatisticsCell.Model(
            totalCovidCases: [
                CellModel(cellNumber: nil, countryName: "Russia", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "Russia", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "Russia", totalCases: 123123, todayCases: 12312)],
            activeCovidCases: [
                CellModel(cellNumber: nil, countryName: "German", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "German", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "German", totalCases: 123123, todayCases: 12312)],
            deathCovidCases: [
                CellModel(cellNumber: nil, countryName: "Canada", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "Canada", totalCases: 123123, todayCases: 12312),
                CellModel(cellNumber: nil, countryName: "Canada", totalCases: 123123, todayCases: 12312)
            ])
        cell.configure(from: model)
        return cell
    }
}
