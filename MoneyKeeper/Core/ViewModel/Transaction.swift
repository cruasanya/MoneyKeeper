//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation

class Transaction:Identifiable, Codable, Equatable{

    var id:UUID = UUID()
    private var destination:String
    private var source:String
    var date:Date
    private var sum: Double

    init(destination: String, source: String, date: Date, sum: Double) {
        self.destination = destination
        self.source = source
        self.date = date
        self.sum = sum
    }

    func getDestination()->String{
        return self.destination
    }
    func getSource()->String{
        return self.source
    }
    func getDate()->String{
        let dateFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    return formatter
                }()
        return dateFormatter.string(from: self.date)
    }
    func getSum()->String{
        return String(self.sum)
    }

    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        if lhs.id == rhs.id{
            return true
        }else{
            return false
        }
    }
}
