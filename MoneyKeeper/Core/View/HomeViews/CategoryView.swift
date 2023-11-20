//
//  CategoryView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 20.11.2023.
//

import SwiftUI

struct CategoryView: View {
    var categories :[Category]
    var delete: (_ category:Category)->Void
    var addCategory:()->Void
    var addSpending:()->Void
    var save: ()->Void
    init(categories: [Category], delete: @escaping (_: Category) -> Void, addCategory: @escaping () -> Void, addSpending: @escaping () -> Void, save: @escaping () -> Void) {
        self.categories = categories
        self.delete = delete
        self.addCategory = addCategory
        self.addSpending = addSpending
        self.save = save
    }
    var body: some View {
        Section("Spending Category"){
            ForEach(categories){ category in
                HStack{
                    Image(systemName: category.getIcon())
                    Text(category.getName())
                    Spacer()
                    Text(String(format: "%.2f", category.getSpending()))
                    Text(" lei")
                }
                .swipeActions(allowsFullSwipe: false){
                    Button(role: .destructive) {
                        withAnimation {
                            delete(category)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                    Button(){
                        addSpending()
                    }label: {
                        HStack{
                            Text("Edit your sources")
                            Image(systemName: "plus.circle")
                        }
                    }
                    .tint(.green)
                })
            }
            Button{
                addCategory()
            }label: {
                HStack{
                    Text("Add new spending category")
                    Spacer()
                    Image(systemName: "plus.circle")
                }
            }
            .foregroundStyle(.green)
        }
    }
}

//#Preview {
//    CategoryView(categories: , delete: , addCategory: , save: )
//}
