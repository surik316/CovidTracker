//
//  CityStatisticsCell.swift
//  CovidTracker
//
//  Created by maksim.surkov on 29.10.2021.
//

import Foundation
import UIKit
import SnapKit

final class CityStatisticsCell: UITableViewCell {
    
    struct Model {
        let city: String
        let todayCovidCases: Int
        let totalCovidCases: Int
        let recoveredCovidCases: Int
        let activeCovidCases: Int
        let deathCovidCases: Int
    }
    
    // MARK: UI элементы
    private let cityButton = CityButton()
    private let todayCovidCasesLabel = UILabel()
    private let titleTotalCasesLabel = UILabel()
    private let totalCovidCasesLabel = UILabel()
    
    private let progressView = ProgressView()
    
    private let titleRecoveredCasesLabel = UILabel()
    private let recoveredCovidCasesLabel = UILabel()
    
    private let titleActiveCasesLable = UILabel()
    private let activeCovidCasesLable = UILabel()
    
    private let titleDeathCasesLable = UILabel()
    private let deathCovidCasesLable = UILabel()
    private let shateButton = ShareButton()
    private let detailsButton = DetailsButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10))
    }
    private func setupUI() {
        addSubview(cityButton)
        cityButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(self.snp.centerX)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
        }
        addSubview(titleTotalCasesLabel)
        titleTotalCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(cityButton.snp.bottom).offset(20)
            make.leading.equalTo(cityButton.snp.leading)
        }
        addSubview(totalCovidCasesLabel)
        totalCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTotalCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleTotalCasesLabel.snp.leading)
        }
        addSubview(todayCovidCasesLabel)
        todayCovidCasesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalCovidCasesLabel.snp.centerY)
            make.leading.equalTo(totalCovidCasesLabel.snp.trailing).offset(5)
        }
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(totalCovidCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(totalCovidCasesLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(10)
        }

        addSubview(titleRecoveredCasesLabel)
        titleRecoveredCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(10)
            make.leading.equalTo(progressView.snp.leading)
        }
        addSubview(recoveredCovidCasesLabel)
        recoveredCovidCasesLabel.font = .systemFont(ofSize: 15)
        recoveredCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleRecoveredCasesLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleRecoveredCasesLabel.snp.leading)
        }

        addSubview(titleDeathCasesLable)
        titleDeathCasesLable.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.trailing.equalTo(progressView.snp.trailing)
        }
        addSubview(deathCovidCasesLable)
        deathCovidCasesLable.snp.makeConstraints { make in
            make.top.equalTo(titleDeathCasesLable.snp.bottom).offset(5)
            make.trailing.equalTo(titleDeathCasesLable.snp.trailing)
        }
        addSubview(titleActiveCasesLable)
        titleActiveCasesLable.snp.makeConstraints { make in
            make.top.equalTo(titleDeathCasesLable.snp.top)
            make.trailing.equalTo(titleDeathCasesLable.snp.leading).offset(-40)
        }
        addSubview(activeCovidCasesLable)
        activeCovidCasesLable.font = .systemFont(ofSize: 15)
        activeCovidCasesLable.snp.makeConstraints { make in
            make.top.equalTo(titleActiveCasesLable.snp.bottom).offset(5)
            make.leading.equalTo(titleActiveCasesLable.snp.leading)
        }
        addSubview(shateButton)
        shateButton.snp.makeConstraints { make in
            make.top.equalTo(recoveredCovidCasesLabel.snp.bottom).offset(20)
            make.leading.equalTo(recoveredCovidCasesLabel.snp.leading)
            make.trailing.equalTo(progressView.snp.centerX).offset(-10)
            make.height.equalTo(40)
        }

        addSubview(detailsButton)
        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(recoveredCovidCasesLabel.snp.bottom).offset(20)
            make.trailing.equalTo(deathCovidCasesLable.snp.trailing)
            make.leading.equalTo(progressView.snp.centerX).offset(10)
            make.height.equalTo(40)
        }
    }
    func configureUI() {
        self.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        titleTotalCasesLabel.text = "Total cases"
        titleTotalCasesLabel.font = .systemFont(ofSize: 15)
        titleTotalCasesLabel.textColor = .white
        totalCovidCasesLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleRecoveredCasesLabel.text = "Recovered"
        titleRecoveredCasesLabel.font = .systemFont(ofSize: 15)
        titleRecoveredCasesLabel.textColor = UIColor(red: 51/255, green: 199/255, blue: 89/255, alpha: 1)
        titleActiveCasesLable.text = "Active"
        titleActiveCasesLable.font = .systemFont(ofSize: 15)
        titleActiveCasesLable.textColor = UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        titleDeathCasesLable.text = "Deaths"
        titleDeathCasesLable.font = .systemFont(ofSize: 15)
        titleDeathCasesLable.textColor = UIColor(red: 253/255, green: 59/255, blue: 48/255, alpha: 1)
        deathCovidCasesLable.font = .systemFont(ofSize: 15)
        activeCovidCasesLable.textColor = .white
        totalCovidCasesLabel.textColor = .white
        deathCovidCasesLable.textColor = .white
        recoveredCovidCasesLabel.textColor = .white
        
        
    }
    func configure(from model: Model) {
        todayCovidCasesLabel.text = "+" + model.todayCovidCases.formattedWithSeparator
        cityButton.descriptionLabel.text = model.city
        totalCovidCasesLabel.text = model.totalCovidCases.formattedWithSeparator
        recoveredCovidCasesLabel.text = model.recoveredCovidCases.formattedWithSeparator
        activeCovidCasesLable.text = model.activeCovidCases.formattedWithSeparator
        deathCovidCasesLable.text = model.deathCovidCases.formattedWithSeparator
        progressView.configure(recoveredCases: model.recoveredCovidCases, activeCases: model.activeCovidCases, deathCases: model.deathCovidCases)
    }
}
