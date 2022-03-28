//
//  ProgressView.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//

import Foundation
import UIKit
import SnapKit

final class ProgressView: UIView {
    
    private let recoveredCasesView = UIView()
    private let activeCasesView = UIView()
    private var recoveredCases: Int!
    private var activeCases: Int!
    private var deathCases: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func setupUI() {
        addSubview(activeCasesView)
        addSubview(recoveredCasesView)
        let total = UIScreen.main.bounds.width - 20
        let totalInt = CGFloat(recoveredCases + activeCases + deathCases)
        let coeffActiveCases = CGFloat(CGFloat(activeCases) / totalInt) + CGFloat(CGFloat(recoveredCases) / totalInt)
        activeCasesView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(total * coeffActiveCases)
        }
        recoveredCasesView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
           make.width.equalTo(total * CGFloat(CGFloat(recoveredCases) / totalInt))
        }
    }
    func configure(recoveredCases: Int, activeCases: Int, deathCases: Int) {
        self.recoveredCases = recoveredCases
        self.activeCases = activeCases
        self.deathCases = deathCases
        setupUI()
    }
    private func configureUI() {
        recoveredCasesView.backgroundColor = UIColor(red: 51/255, green: 199/255, blue: 89/255, alpha: 1)
        activeCasesView.backgroundColor =  UIColor(red: 1, green: 148/255, blue: 0, alpha: 1)
        backgroundColor =  UIColor(red: 253/255, green: 59/255, blue: 48/255, alpha: 1)
    }
}
