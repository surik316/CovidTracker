//
//  TextCellModel.swift
//  CovidTracker
//
//  Created by maksim.surkov on 28.03.2022.
//

import Foundation
import UIKit

protocol SimpleCellViewModel {}

struct TextCellViewModel: SimpleCellViewModel {
    let text: String
    let textColor: UIColor
}
