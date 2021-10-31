//
//  CityButton.swift
//  CovidTracker
//
//  Created by maksim.surkov on 31.10.2021.
//
import Foundation
import UIKit
import SnapKit

class CityButton: UIButton {
    private let locationImageView = UIImageView()
    var descriptionLabel = UILabel()
    private let arrowDownImageView = UIImageView()
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
        addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.centerY.equalToSuperview()
        }
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        addSubview(arrowDownImageView)
        arrowDownImageView.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        locationImageView.image = UIImage(systemName: "location.north.fill")
        arrowDownImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        descriptionLabel.text = "Moskow"
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 25)
        descriptionLabel.textColor = .white
        backgroundColor = UIColor(red: 27/255, green: 28/255, blue: 30/255, alpha: 1)
        layer.cornerRadius = 5
    }
}
