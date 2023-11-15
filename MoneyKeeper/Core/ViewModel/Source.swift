//
//  Source.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation

class Source:Identifiable, Hashable,Codable{
    var id = UUID()
    private var name:String
    private var balance: Double
    private var iconName:String
    init(name: String, balance: Double, iconName: String) {
        self.name = name
        self.balance = balance
        self.iconName = iconName
    }
    func getName()->String{
        return self.name
    }
    func getBalance()->Double{
        return self.balance
    }
    func getIcon()->String{
        return self.iconName
    }
    func modifyBalance(by money:Double){
        self.balance += money
    }
    func changeBalance(by money:Double){
        self.balance = money
    }


    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
    static func == (lhs: Source, rhs: Source) -> Bool {
        if lhs.id == rhs.id{
            return true
        }else{
            return false
        }
    }
    
}
