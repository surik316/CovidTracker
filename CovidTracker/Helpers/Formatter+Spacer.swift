//
//  Formatter+Spacer.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//

import Foundation
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
