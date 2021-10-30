//
//  ShareButton.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//

import Foundation
import UIKit
import SnapKit

class ShareButton: UIButton {
    
    private let shareImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func setupUI() {
        addSubview(shareImageView)
        //shareImageView.tra
    }
    
    private func configureUI() {
        shareImageView.image = UIImage(systemName: "square.and.arrow.up")
        descriptionLabel.text = "Share"
        descriptionLabel.font = .systemFont(ofSize: 15)
    }
}
