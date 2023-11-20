//
//  History.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation
import SwiftUICharts

class History : Codable{
    private var  transactions: [Transaction] = []

    func addTransaction(transaction:Transaction){
        self.transactions.append(transaction)
    }

    func getTransactions()->[Transaction]{
        return self.transactions
    }
    func getTransactions(from date: Date) -> [Transaction] {
        var selectedTransactions: [Transaction] = []
        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        for transaction in transactions {
            let transactionDateComponents = calendar.dateComponents([.year, .month, .day], from: transaction.date)

            if selectedDateComponents == transactionDateComponents {
                selectedTransactions.append(transaction)
            }
        }
        return selectedTransactions
    }

    func deleteTransaction(transaction:Transaction){
        if let index = transactions.firstIndex(of: transaction){
            transactions.remove(at: index)
        }
    }

    func getTransactionData() -> ChartData {
        var transactionSums: [Double] = []

        for transaction in transactions {
            if let sum = Double(transaction.getSum()) {
                transactionSums.append(sum)
            } else {
                print("Error converting sum for transaction: \(transaction.getSum())")
            }
        }

        return ChartData(points: transactionSums)
    }
    func getTransactionSum()-> [Double]{
        var transactionSums: [Double] = []
        for transaction in transactions {
            if let sum = Double(transaction.getSum()) {
                transactionSums.append(sum)
            } else {
                print("Error converting sum for transaction: \(transaction.getSum())")
            }
        }
        return transactionSums
    }

}
