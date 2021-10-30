//
//  Numeric+Spacer.swift
//  CovidTracker
//
//  Created by maksim.surkov on 30.10.2021.
//

import Foundation
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
