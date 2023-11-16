//
//  StatisticView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 16.11.2023.
//

import SwiftUI
import SwiftUICharts

struct StatisticView: View {
    var history:History
    let chartStyle =    ChartStyle(backgroundColor: .black, accentColor: .cyan, secondGradientColor: .green, textColor: .white, legendTextColor: .white, dropShadowColor: .black)
    var body: some View {
        BarChartView(data: history.getTransactionData(), title: "Transaction", form: ChartForm.extraLarge)
            .changeColorScheme(style: chartStyle)
        LineChartView(data: history.getTransactionSum(), title: "Transaction", style: chartStyle, rateValue: nil)


    }
    
}

#Preview {
    StatisticView(history: History())
}
