//
//  HomeView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 15.11.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user:User
    @State var showingSourceAdding:Bool = false
    @State var showingCategoryAdding:Bool = false
    @State var showingAddHistory:Bool = false
    var body: some View {
        ZStack{
            Color("background")
            List{
                SourcesView(sources: user.getSources(),
                            delete: user.deleteSource(source:),
                            addSource: {self.showingSourceAdding.toggle()}, 
                            save: {
                                user.calculateBalance()
                                user.fetch()
                            })
                CategoryView(categories: user.getCategories(),
                             delete: user.deleteCategorie(category:),
                             addCategory: {self.showingCategoryAdding.toggle()}, 
                             addSpending: {showingAddHistory.toggle()},
                             save: {
                                user.calculateBalance()
                                user.fetch()
                            })
                Section("Today's History"){
                    Button(action: {
                        showingAddHistory.toggle()
                    }, label: {
                        HStack{
                            Text("Add history")
                            Spacer()
                            Image(systemName: "plus.circle")
                        }
                    })
                    .foregroundStyle(.green)
                    ForEach(user.getTransactions(from: .now)){ transaction in
                        VStack(alignment:.leading){
                            HStack{
                                Text(transaction.getSource())
                                Image(systemName: "arrow.right")
                                Text(transaction.getDestination())
                                Text(transaction.getSum())
                                Text(" lei")
                                Spacer()
                            }
                            HStack{
                                Text(transaction.getDate())
                                Spacer()
                            }
                        }
                        .swipeActions{
                            Button(role: .destructive) {
                                withAnimation {
                                    user.deleteTransaction(transaction: transaction)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }


                    }
                }
            }
        }
        .sheet(isPresented: $showingSourceAdding, content: {
            AddingSourceCategoryView(name: "source", add: {showingSourceAdding.toggle()})
                .environmentObject(user)
                .presentationDetents([.medium])
        })
        .sheet(isPresented: $showingCategoryAdding, content: {
            AddingSourceCategoryView(name: "category", add: {showingCategoryAdding.toggle()})
                .environmentObject(user)
                .presentationDetents([.medium])
        })
        .sheet(isPresented: $showingAddHistory, content: {
            AddHistoryView(add: {showingAddHistory.toggle()})
                .environmentObject(user)
                .presentationDetents([.medium])
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(User(name: "Alex", surname: "Novicov"))
}
