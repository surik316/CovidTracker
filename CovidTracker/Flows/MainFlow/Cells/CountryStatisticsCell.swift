//
//  CountryStatisticsCell.swift
//  CovidTracker
//
//  Created by maksim.surkov on 29.10.2021.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Charts

final class CountryStatisticsCell: UITableViewCell {
    
    struct Model {
        let date: String
        let todayCovidCases: Int
        let theDayBeforeCovidCases: Int
        let totalCovidCases: Int
        let recoveredCovidCases: Int
        let activeCovidCases: Int
        let deathCovidCases: Int
        let last14DaysCases: [Int]
        
    }
    // MARK: UI элементы
    private let descriptionLabel = UILabel()
    private let countryButton = CountryButton()
    private let dateLabel = UILabel()
    private let todayCovidCasesLabel = UILabel()
    private let upDownArrowImageView = UIImageView()
    private let theDayBeforeCovidCasesLabel = UILabel()
    private let barChartView = BarChartView()
    private let barChartTitle = UILabel()
    private let separatorView = UIView()
    
    private let titleTotalCasesLabel = UILabel()
    private let totalCovidCasesLabel = UILabel()
    
    private let progressView = ProgressView()
    
    private let titleRecoveredCasesLabel = UILabel()
    private let recoveredCovidCasesLabel = UILabel()
    
    private let titleActiveCasesLable = UILabel()
    private let activeCovidCasesLabel = UILabel()
    
    private let titleDeathCasesLable = UILabel()
    private let deathCovidCasesLabel = UILabel()
    private let shateButton = ShareButton()
    private let detailsButton = DetailsButton()
    private var bag = DisposeBag()
    
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

        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        addSubview(countryButton)
        countryButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.trailing.equalTo(descriptionLabel.snp.trailing).offset(20)
            make.height.equalTo(40)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(countryButton.snp.bottom).offset(10)
            make.leading.equalTo(descriptionLabel.snp.leading)
        }
        
        addSubview(todayCovidCasesLabel)
        todayCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.equalTo(dateLabel.snp.leading)
        }
    
        addSubview(upDownArrowImageView)
        upDownArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(todayCovidCasesLabel.snp.centerY)
            make.leading.equalTo(todayCovidCasesLabel.snp.trailing).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        addSubview(barChartTitle)
        barChartTitle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(dateLabel.snp.top)
        }
        
        addSubview(barChartView)
        var entries = [BarChartDataEntry()]
        for x in 0..<14 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double.random(in: 1...10)))
        }
        let set = BarChartDataSet(entries: entries)
        set.drawValuesEnabled = false
        set.colors = [UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)]
        let data = BarChartData(dataSet: set)
        barChartView.data = data

        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.enabled = false
        barChartView.legend.enabled = false
        
        //barChartView.drawValueAboveBarEnabled = false
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(barChartTitle.snp.bottom).offset(10)
            make.trailing.equalTo(barChartTitle.snp.trailing)
            make.height.equalTo(70)
            make.width.equalTo(100)
        }
        
        addSubview(theDayBeforeCovidCasesLabel)
        theDayBeforeCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(todayCovidCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(todayCovidCasesLabel.snp.leading)
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(theDayBeforeCovidCasesLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(1)
        }
        
        addSubview(titleTotalCasesLabel)
        titleTotalCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10)
            make.leading.equalTo(todayCovidCasesLabel.snp.leading)
        }
        addSubview(totalCovidCasesLabel)
        totalCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTotalCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(todayCovidCasesLabel.snp.leading)
        }
        
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(totalCovidCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(totalCovidCasesLabel.snp.leading)
            make.trailing.equalTo(barChartTitle.snp.trailing)
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
        
        addSubview(titleActiveCasesLable)
        titleActiveCasesLable.snp.makeConstraints { make in
            make.top.equalTo(titleRecoveredCasesLabel.snp.top)
            make.centerX.equalTo(self.snp.centerX)
        }
        addSubview(activeCovidCasesLabel)
        activeCovidCasesLabel.font = .systemFont(ofSize: 15)
        activeCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleActiveCasesLable.snp.bottom).offset(5)
            make.leading.equalTo(titleActiveCasesLable.snp.leading)
        }
        
        addSubview(titleDeathCasesLable)
        titleDeathCasesLable.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.trailing.equalTo(progressView.snp.trailing)
        }
        addSubview(deathCovidCasesLabel)
        deathCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleDeathCasesLable.snp.bottom).offset(5)
            make.trailing.equalTo(titleDeathCasesLable.snp.trailing)
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
            make.trailing.equalTo(deathCovidCasesLabel.snp.trailing)
            make.leading.equalTo(progressView.snp.centerX).offset(10)
            make.height.equalTo(40)
        }
    }
    func configureUI() {
        self.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        descriptionLabel.text = "Statistics"
        descriptionLabel.font = .systemFont(ofSize: 35, weight: .bold)
        descriptionLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 15)
        barChartTitle.text = "last 14 days"
        barChartTitle.textColor = .white
        barChartTitle.font = .systemFont(ofSize: 15)
        separatorView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        titleTotalCasesLabel.text = "Total cases"
        titleTotalCasesLabel.font = .systemFont(ofSize: 15)
        titleTotalCasesLabel.textColor = .white
        totalCovidCasesLabel.font = .systemFont(ofSize: 25, weight: .bold)
        totalCovidCasesLabel.textColor = .white
        recoveredCovidCasesLabel.textColor = .white
        deathCovidCasesLabel.textColor = .white
        activeCovidCasesLabel.textColor = .white
        theDayBeforeCovidCasesLabel.font = .systemFont(ofSize: 15)
        theDayBeforeCovidCasesLabel.textColor = .systemGray
        titleRecoveredCasesLabel.text = "Recovered"
        titleRecoveredCasesLabel.font = .systemFont(ofSize: 15)
        titleRecoveredCasesLabel.textColor = UIColor(red: 51/255, green: 199/255, blue: 89/255, alpha: 1)
        titleActiveCasesLable.text = "Active"
        titleActiveCasesLable.font = .systemFont(ofSize: 15)
        titleActiveCasesLable.textColor = UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        titleDeathCasesLable.text = "Deaths"
        titleDeathCasesLable.font = .systemFont(ofSize: 15)
        titleDeathCasesLable.textColor = UIColor(red: 253/255, green: 59/255, blue: 48/255, alpha: 1)
        deathCovidCasesLabel.font = .systemFont(ofSize: 15)
        todayCovidCasesLabel.textColor = UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        todayCovidCasesLabel.font = .systemFont(ofSize: 38, weight: .bold)
        dateLabel.textColor = .white
    }
    func configure(from model: CountryInfoModel) {
        let model = Model(date: "11/12/22", todayCovidCases: 123,
                          theDayBeforeCovidCases: model.updated, totalCovidCases: model.cases,
                          recoveredCovidCases: model.todayRecovered, activeCovidCases: model.updated,
                          deathCovidCases: model.deaths, last14DaysCases: [])
        dateLabel.text = model.date
        todayCovidCasesLabel.text = "+" + model.todayCovidCases.formattedWithSeparator
        theDayBeforeCovidCasesLabel.text = "+" + model.theDayBeforeCovidCases.formattedWithSeparator + " the day before"
        totalCovidCasesLabel.text = model.totalCovidCases.formattedWithSeparator
        recoveredCovidCasesLabel.text = model.recoveredCovidCases.formattedWithSeparator
        activeCovidCasesLabel.text = model.activeCovidCases.formattedWithSeparator
        deathCovidCasesLabel.text = model.deathCovidCases.formattedWithSeparator
        upDownArrowImageView.image = model.todayCovidCases > model.theDayBeforeCovidCases ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down")
        progressView.configure(recoveredCases: model.recoveredCovidCases, activeCases: model.activeCovidCases, deathCases: model.deathCovidCases)
    }
}
