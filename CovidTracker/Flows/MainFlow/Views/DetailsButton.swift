//
//  DetailsButton.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//
import Foundation
import UIKit
import SnapKit

class DetailsButton: UIButton {
    
    private let detailsImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(-10)
            make.centerY.equalToSuperview()
        }
        addSubview(detailsImageView)
        detailsImageView.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionLabel.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
    private func configureUI() {
        detailsImageView.image = UIImage(named: "circleDots")
        descriptionLabel.text = "Details"
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .white
        backgroundColor = UIColor(red: 11/255, green: 131/255, blue: 1, alpha: 1)
        layer.cornerRadius = 5
    }
}
