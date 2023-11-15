//
//  Category.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation

class Category:Identifiable, Hashable, Codable{

    var id = UUID()
    private var name:String
    private var spending:Double
    private var iconName:String

    init(name: String, spending: Double,iconName:String) {
        self.name = name
        self.spending = spending
        self.iconName = iconName
    }
    func getName()->String{
        return self.name
    }
    func getSpending()->Double{
        return self.spending
    }
    func getIcon()->String{
        return self.iconName
    }
    func modifySpending(by money:Double){
        self.spending += money
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }

    static func == (lhs: Category, rhs: Category) -> Bool {
        if lhs.id == rhs.id{
            return true
        }else{
            return false
        }
    }
}
