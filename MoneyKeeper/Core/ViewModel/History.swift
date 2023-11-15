//
//  History.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation

class History : Codable{
    private var  transactions: [Transaction] = []

    func addTransaction(transaction:Transaction){
        self.transactions.append(transaction)
    }

    func getTransactions()->[Transaction]{
        return self.transactions
    }

    func deleteTransaction(transaction:Transaction){
        if let index = transactions.firstIndex(of: transaction){
            transactions.remove(at: index)
        }
    }

}
