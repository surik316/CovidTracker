//
//  RestWorldStatisticsCell.swift
//  CovidTracker
//
//  Created by maksim.surkov on 29.10.2021.
//
import Foundation
import UIKit
import SnapKit
import Charts
import RxCocoa
import RxSwift

struct CellModel {
    let countryName: String
    let totalCases: Int
    let todayCases: Int
}

final class RestWorldStatisticsCell: UITableViewCell {
    
    struct Model {
        let totalCovidCases: [CellModel]
        let activeCovidCases: [CellModel]
        let deathCovidCases: [CellModel]
    }
    
    // MARK: UI элементы
    private let tableView = UITableView()
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Total cases", "Active cases", "Deaths"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    private var bag = DisposeBag()
    private var totalCovidCases = [CellModel]()
    private var activeCovidCases = [CellModel]()
    private var deathCovidCases = [CellModel]()
    private let identifierCell = "cellResetWorld"
    lazy var rowsToDisplay = PublishSubject<[CellModel]>()
    private let disposeBag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setUpBindings()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setUpBindings()
        configureUI()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func setUpBindings() {
        segmentedControl.rx.controlEvent(.valueChanged).withLatestFrom(segmentedControl.rx.value).subscribe(onNext : { value in
            switch value {
            case 0:
                self.rowsToDisplay.onNext(self.totalCovidCases)
            case 1:
                self.rowsToDisplay.onNext(self.activeCovidCases)
            default:
                self.rowsToDisplay.onNext(self.deathCovidCases)
            }
        }).disposed(by: disposeBag)
        
        rowsToDisplay.asObservable().bind(to: tableView.rx.items(cellIdentifier: identifierCell)) { row, model, cell in
            if let cell = cell as? CellTableView {
                cell.configure(from: model, row: row)
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CellModel.self).subscribe(onNext: { model in
            print(model)
        }).disposed(by: disposeBag)
    }
    private func setupUI() {
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-15)
        }
        tableView.register(CellTableView.self, forCellReuseIdentifier: identifierCell)
        
        
    }
    func configureUI() {
        self.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        contentView.isUserInteractionEnabled = false
        tableView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        
        selectionStyle = .none
    }
    func configure(from model: Model) {
        self.totalCovidCases = model.totalCovidCases
        self.activeCovidCases = model.activeCovidCases
        self.deathCovidCases = model.deathCovidCases
        self.rowsToDisplay.onNext(self.totalCovidCases)
    }
}
extension RestWorldStatisticsCell {
    class CellTableView: UITableViewCell {
        private let cellNumberLabel = UILabel()
        private let countryLabel = UILabel()
        private let totalCasesLabel = UILabel()
        private let todayCasesLabel = UILabel()
        private let rightArrowImageView = UIImageView()
        
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
            addSubview(cellNumberLabel)
            cellNumberLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
            }
            addSubview(countryLabel)
            countryLabel.snp.makeConstraints { make in
                make.leading.equalTo(cellNumberLabel.snp.trailing).offset(10)
                make.centerY.equalToSuperview()
            }
            addSubview(rightArrowImageView)
            rightArrowImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-10)
                make.height.equalTo(18)
                make.width.equalTo(12)
            }
            addSubview(totalCasesLabel)
            totalCasesLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalTo(rightArrowImageView.snp.leading).offset(-82)
            }
            addSubview(todayCasesLabel)
            todayCasesLabel.snp.makeConstraints { make in
                make.bottom.equalTo(totalCasesLabel.snp.bottom)
                make.leading.equalTo(totalCasesLabel.snp.trailing).offset(4)
            }
            
        }
        private func configureUI() {
            rightArrowImageView.image = UIImage(systemName: "arrow.right")
            backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
            cellNumberLabel.textColor = .white
            countryLabel.textColor = .white
            totalCasesLabel.textColor = .white
            totalCasesLabel.font = .systemFont(ofSize: 15, weight: .bold)
            todayCasesLabel.font = .systemFont(ofSize: 10, weight: .bold)
            totalCasesLabel.textColor = .white
        }
        func configure(from model: CellModel, row: Int) {
            cellNumberLabel.text = String(row)
            countryLabel.text = model.countryName
            totalCasesLabel.text = model.totalCases.formattedWithSeparator
            todayCasesLabel.text = "+" + model.todayCases.formattedWithSeparator
            todayCasesLabel.textColor = UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        }
        
    }
}
