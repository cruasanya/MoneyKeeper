//
//  CustomizationView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct AddingSourceCategoryView: View {
    @EnvironmentObject var user:User
    var name:String
    @State var nameText:String = ""
    @State var balance:String = ""
    @State var selectedIcon:String = ""
    @State var add: ()->Void


    var body: some View {
        VStack(alignment:.center){
            VStack(alignment: .leading,spacing: 12){
                Text("Add new \(name) name ")
                    .font(.system(size:20))
                    .fontWeight(.semibold)
                    .font(.footnote)


                    TextField("Input name",text: $nameText)
                        .font(.system(size:14))
                Divider()

                if name == "source"{
                    Text("Add balance of \(name)")
                        .font(.system(size:20))
                        .fontWeight(.semibold)
                        .font(.footnote)

                    TextField("Input balance",text: $balance)
                            .font(.system(size:14))
                }

                Text("Select \(name) icon")
                    .font(.system(size:20))
                    .fontWeight(.semibold)
                    .font(.footnote)
                Picker("Select an icon: ", selection: $selectedIcon) {
                    if name == "source"{
                        ForEach(user.getPosibleSourceIcon(), id:\.self){ possibleIcon in
                            Image(systemName: possibleIcon)
                        }
                    }else{
                        ForEach(user.getPosibleCategoryIcon(), id:\.self){ possibleIcon in
                            Image(systemName: possibleIcon)
                        }
                    }
                }.pickerStyle(.segmented)

            }
            .padding()
            Button{
                if name == "source"{
                    guard let addingBalance = Double(self.balance) else {return}
                    user.addSource(name: nameText, balance: addingBalance, iconName: selectedIcon)
                    user.calculateBalance()
                    user.save()
                    add()
                }else{
                    user.addSpending(name: nameText, spending: 0, iconName: selectedIcon)
                    user.save()
                    add()
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

#Preview {
    AddingSourceCategoryView( name: "source", add: {})
        .environmentObject(User(name: "", surname: ""))
}
