//
//  ShareButton.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//

import Foundation
import UIKit
import SnapKit

final class ShareButton: UIButton {
    
    private let shareImageView = UIImageView()
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
        addSubview(shareImageView)
        shareImageView.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionLabel.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        shareImageView.image = UIImage(systemName: "square.and.arrow.up")
        descriptionLabel.text = "Share"
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .white
        backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        layer.cornerRadius = 5
    }
}
