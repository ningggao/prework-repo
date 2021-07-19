//
//  GlobalPicker.swift
//  Prework
//
//  Created by Ning on 7/18/21.
//

import Foundation
import SwiftTheme

enum GlobalPicker {
    static let backgroundColor: ThemeColorPicker = ["#E0E0E0", "#E0E0E0", "#E0E0E0", "#292b38"]
    static let textColor: ThemeColorPicker = ["#000", "#000", "#000", "#ECF0F1"]
    
    static let barTextColors = ["#000", "#000", "#000", "#ECF0F1"]
    
    static let barTextColor = ThemeColorPicker.pickerWithColors(barTextColors)
    static let barTintColor: ThemeColorPicker = ["#EB4F38", "#F4C600", "#56ABE4", "#01040D"]
}
