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
    @State var showingSourceEditing:Bool = false
    @State var showingCategoryAdding:Bool = false
    @State var showingAddHistory:Bool = false
    var body: some View {
        ZStack{
            Color("background")
            List{
                Section("Sources"){
                    ForEach(user.getSources()){ source in

                        HStack{
                            Image(systemName: source.getIcon())
                            Text(source.getName())
                            Spacer()
                            Text(String(format: "%.2f", source.getBalance()))
                            Text(" lei")
                        }

                        .swipeActions{
                            Button(role: .destructive) {
                                withAnimation {
                                    user.deleteSource(source: source)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .contextMenu{
                            Button{
                                showingSourceEditing.toggle()
                            }label: {
                                HStack{
                                    Text("Edit your sources")
                                    Image(systemName: "pencil.circle")
                                }
                            }
                            .foregroundStyle(.green)

                            Button(role: .destructive) {
                                withAnimation {
                                    user.deleteSource(source: source)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }

                    Button{
                        showingSourceAdding.toggle()
                    }label: {
                        HStack{
                            Text("Add new source")
                            Image(systemName: "plus.circle")
                        }
                    }
                    .foregroundStyle(.green)



                }
                Section("Spending Category"){
                    ForEach(user.getCategories()){ category in
                        HStack{
                            Image(systemName: category.getIcon())
                            Text(category.getName())
                            Spacer()
                            Text(String(format: "%.2f", category.getSpending()))
                            Text(" lei")
                        }
                        .swipeActions{
                            Button(role: .destructive) {
                                withAnimation {
                                    user.deleteCategorie(category: category)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    Button{
                        showingCategoryAdding.toggle()
                    }label: {
                        HStack{
                            Text("Add new spending category")
                            Spacer()
                            Image(systemName: "plus.circle")
                        }
                    }
                    .buttonStyle(.plain)
                }
                Section("History"){
                    Button(action: {
                        showingAddHistory.toggle()
                    }, label: {
                        HStack{
                            Text("Add history")
                            Spacer()
                            Image(systemName: "plus.circle")
                        }
                    })
                    .buttonStyle(.plain)
                    ForEach(user.getTranasaction()){ transaction in
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
        .sheet(isPresented: $showingSourceEditing, content: {
            EditView(editingSources: user.getSources())
                .presentationDetents([.medium])
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(User(name: "Alex", surname: "Novicov"))
}