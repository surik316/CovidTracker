//
//  WorldStatisticsCell.swift
//  CovidTracker
//
//  Created by maksim.surkov on 29.10.2021.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Charts

class WorldStatisticsCell: UITableViewCell {
    struct Model {
        let todayCovidCases: Int
        let totalCovidCases: Int
        let recoveredCovidCases: Int
        let activeCovidCases: Int
        let deathCovidCases: Int
    }
    // MARK: UI элементы
    private let planetImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let todayCovidCasesLabel = UILabel()
    private let totalCovidCasesLabel = UILabel()
    private let titleTotalCasesLabel = UILabel()
    
    private let pieChartView = PieChartView()
    
    private let titleRecoveredCasesLabel = UILabel()
    private let recoveredCovidCasesLabel = UILabel()
    
    private let titleActiveCasesLable = UILabel()
    private let activeCovidCasesLable = UILabel()
    
    private let titleDeathCasesLable = UILabel()
    private let deathCovidCasesLable = UILabel()
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
    private func setupUI() {
        addSubview(planetImageView)
        planetImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(planetImageView.snp.trailing).offset(10)
            make.centerY.equalTo(planetImageView.snp.centerY)
        }
        addSubview(totalCovidCasesLabel)
        totalCovidCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            make.leading.equalTo(planetImageView.snp.leading)
        }
        addSubview(titleTotalCasesLabel)
        titleTotalCasesLabel.snp.makeConstraints { make in
            make.top.equalTo(totalCovidCasesLabel.snp.bottom).offset(10)
            make.leading.equalTo(totalCovidCasesLabel.snp.leading)
        }
        addSubview(todayCovidCasesLabel)
        todayCovidCasesLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalCovidCasesLabel.snp.bottom).offset(-5)
            make.leading.equalTo(totalCovidCasesLabel.snp.trailing).offset(5)
        }
        var recdataEntry = PieChartDataEntry(value: 0)
        var actdataEntry = PieChartDataEntry(value: 0)
        var pieCharDataEntries = [PieChartDataEntry]()
        recdataEntry.value = 10
        actdataEntry.value = 20
        
        pieCharDataEntries = [recdataEntry, actdataEntry]
        let chartDataSet = PieChartDataSet(entries: pieCharDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [UIColor.red, UIColor.orange]
        chartDataSet.colors = colors
        chartDataSet.drawValuesEnabled = false
        pieChartView.data = chartData
        pieChartView.legend.enabled = false
        pieChartView.holeColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        pieChartView.holeRadiusPercent = 0.8
        addSubview(pieChartView)
        pieChartView.snp.makeConstraints { make in
            make.top.equalTo(titleTotalCasesLabel.snp.bottom).offset(25)
            make.leading.equalTo(titleTotalCasesLabel.snp.leading).offset(-20)
            make.width.equalTo(180)
            make.height.equalTo(180)
        }
        
    }
    func configureUI() {
        self.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        descriptionLabel.text = "World"
        planetImageView.image = UIImage(named: "planet")
        todayCovidCasesLabel.textColor = UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        
        titleTotalCasesLabel.text = "Total cases"
        titleTotalCasesLabel.font = .systemFont(ofSize: 15)
        titleTotalCasesLabel.textColor = .white
        totalCovidCasesLabel.font = .systemFont(ofSize: 40, weight: .bold)
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
        
    }
    func configure(from model: Model) {
        todayCovidCasesLabel.text = "+" + model.todayCovidCases.formattedWithSeparator
        totalCovidCasesLabel.text = model.totalCovidCases.formattedWithSeparator
        recoveredCovidCasesLabel.text = model.recoveredCovidCases.formattedWithSeparator
        activeCovidCasesLable.text = model.activeCovidCases.formattedWithSeparator
        deathCovidCasesLable.text = model.deathCovidCases.formattedWithSeparator
    }
}
