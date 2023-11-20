//
//  User.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import Foundation

class User:ObservableObject{
    private var name:String
    private var surname:String
    private var history = History()
    @Published private var sources:[Source] = []
    @Published private var categories:[Category] = []
    @Published private var balance:Double = 0
    private let savePathSources = FileManager.documentsDirectory.appendingPathComponent("Saved Source")
    private let savePatchCategories = FileManager.documentsDirectory.appendingPathComponent("Saved Categories")
    private let savePathHistory = FileManager.documentsDirectory.appendingPathComponent("Saved History")


    init(name: String, surname: String) {
        self.name = name
        self.surname = surname

        fetch()

        calculateBalance()
    }
    func save() {
        do {
            let historyData = try JSONEncoder().encode(history)
            try historyData.write(to: savePathHistory, options: [.atomic, .completeFileProtection])

            let sourcesData = try JSONEncoder().encode(sources)
            try sourcesData.write(to: savePathSources, options: [.atomic, .completeFileProtection])

            let categoriesData = try JSONEncoder().encode(categories)
            try categoriesData.write(to: savePatchCategories, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data: \(error)")
        }

    }
    func fetch(){
        do{
            let sourcesData = try Data(contentsOf: savePathSources)
            sources = try JSONDecoder().decode([Source].self, from:sourcesData)
            let categoriesData = try Data(contentsOf: savePatchCategories)
            categories = try JSONDecoder().decode([Category].self, from:categoriesData)
            let historyData = try Data(contentsOf: savePathHistory)
            history = try JSONDecoder().decode(History.self, from: historyData)
        }catch{
            print("Unable to fetch data: \(error)")
        }
    }

    func calculateBalance(){
        var balance:Double = 0
        for source in sources {
            balance += source.getBalance()
        }
        self.balance = balance
        save()
    }

    func getfullName()->String{
        return "\(self.name) \(self.surname)"
    }
    func getInitials()->String{
        let formatter  = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: self.getfullName()){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    func getBalance()->String{
        return String(self.balance)
    }
    func getSources()->[Source]{
        return self.sources
    }
    func getCategories()->[Category]{
        return self.categories
    }
    func getTransactionHistory()->History{
        return self.history
    }
    func getTranasactions()->[Transaction]{
        return self.history.getTransactions()
    }
    func getTransactions(from date: Date)->[Transaction]{
        return self.history.getTransactions(from: date)
    }
    func getPosibleCategoryIcon()->[String]{
        return ["fork.knife","cup.and.saucer","gym.bag","globe.europe.africa","heart.circle"]
    }
    func getPosibleSourceIcon()->[String]{
        return ["creditcard", "dollarsign.circle"]
    }

    func addSource(name: String, balance:Double,iconName:String){
        self.sources.append(Source(name: name, balance: balance, iconName: iconName))
        save()
    }

    func addSpending(name:String, spending:Double,iconName:String){
        self.categories.append(Category(name: name, spending: spending, iconName: iconName))
        save()
    }

    func transferMoney(source:Source, destination:Source, money: Double){
        source.modifyBalance(by: -money)
        destination.modifyBalance(by: money)
        history.addTransaction(
            transaction:Transaction(
                destination: destination.getName(),
                source: source.getName(),
                            date: Date(),
                            sum: money
            )
        )
        save()
    }
    func spendingMoney(source:Source, destination:Category,money:Double){
        source.modifyBalance(by: -money)
        destination.modifySpending(by: money)
        history.addTransaction(
            transaction:Transaction(
                destination: destination.getName(),
                source: source.getName(),
                            date: Date(),
                            sum: money
            )
        )
        save()
    }
    func deleteSource(source: Source){
        if let index = sources.firstIndex(of: source) {
            sources.remove(at: index)
            save()
            calculateBalance()
        }
    }
    func deleteCategorie(category: Category){
        if let index = categories.firstIndex(of: category) {
            categories.remove(at: index)
            save()
        }
    }
    func deleteTransaction(transaction:Transaction){
        history.deleteTransaction(transaction: transaction)
        save()
    }
}
