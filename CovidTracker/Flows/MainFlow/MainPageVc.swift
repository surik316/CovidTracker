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

class MainPageVC: UIViewController {
    
    
    // MARK: UI элементы
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: Приватные свойства
    private let bag = DisposeBag()

    // MARK: Публичные свойства
    //var viewModel: MainPageViewModel = .init()
    
    // MARK: override свойства
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: override методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupUI() {
        view.addSubview(collectionView)

        view.backgroundColor = .systemGray3
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryStatisticsCell.self, forCellWithReuseIdentifier: "CountryStatisticsCell")
    }
    
    private func configure() {
        
    }
    
    private func setupBindings() {
        
    }
    
}
extension MainPageVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: view.frame.width, height: 400)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryStatisticsCell", for: indexPath) as! CountryStatisticsCell
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
}
