//
//  AddHistoryView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct AddHistoryView: View {
    @State var add: ()->Void
    @EnvironmentObject var user:User
    @State var selectedSource:Source?
    @State var selectedDestination:Category?
    @State var sumNumber:String = ""


    var body: some View {
        if user.getSources().isEmpty{
            Text("Please add sources")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }else if user.getCategories().isEmpty{
            Text("Please add categories")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }else{
            VStack(alignment:.center){
                VStack(alignment:.leading){
                    VStack{
                        HStack{
                            Text("Enter sum:")
                                .font(.system(size:20))
                                .fontWeight(.semibold)
                                .font(.footnote)
                            Spacer()
                        }

                        TextField("100.0",text: $sumNumber)
                            .font(.system(size:14))
                    }.padding()
                    Divider()
                    HStack{
                        Picker("Source", selection: $selectedSource) {
                            Text("Change Souce")
                            ForEach(user.getSources()){ source in
                                Text("\(source.getName())").tag(Optional(source))
                            }
                        }
                        .pickerStyle(.wheel)

                        Image(systemName: "arrow.right")

                        Picker("Destination", selection: $selectedDestination) {
                            Text("Change Destination")
                            ForEach(user.getCategories()){ category in
                                Text("\(category.getName())").tag(Optional(category))
                            }
                        }
                        .pickerStyle(.wheel)

                    }

                }
                Button{

                    if let source = user.getSources().first(where: { $0.getName() == selectedSource?.getName() }) {
                        if let category = user.getCategories().first(where: { $0.getName() == selectedDestination?.getName() }) {
                            guard let addingBalance = Double(sumNumber) else {return}
                            user.spendingMoney(source: source, destination: category, money: addingBalance)
                            user.calculateBalance()
                            user.save()
                            add()
                        }
                    }
                } label: {
                    HStack{
                        Text("Add")
                        Image(systemName: "plus.circle")
                    }
                    .frame(width: 350, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .foregroundStyle(.green)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    AddHistoryView(add: {})
        .environmentObject(User(name: "", surname: ""))
}
