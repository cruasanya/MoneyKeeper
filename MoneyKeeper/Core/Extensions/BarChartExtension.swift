//
//  BarChartExtension.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 16.11.2023.
//

import Foundation
import SwiftUICharts
import SwiftUI

extension BarChartView {
    func changeColorScheme(style: ChartStyle) -> BarChartView {
        var modifiedSelf = self
        modifiedSelf.style = style
        return modifiedSelf
    }
}
