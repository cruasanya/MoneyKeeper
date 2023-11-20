//
//  SourcesView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 15.11.2023.
//

import SwiftUI

struct SourcesView: View {
    @State var showingSourceEditing:Bool = false
    @State var editingSource:Source = Source(name: "", balance: 0, iconName: "plus")

    var sources :[Source]
    var delete: (_ source:Source)->Void
    var addSource:()->Void
    var save: ()->Void
    init(sources: [Source], delete: @escaping (_ source:Source) -> Void, addSource: @escaping ()->Void, save: @escaping ()->Void) {
        self.sources = sources
        self.delete = delete
        self.addSource = addSource
        self.save = save
    }
    var body: some View {
        Section("Sources"){
            ForEach(sources){ source in

                HStack{
                    Image(systemName: source.getIcon())
                    Text(source.getName())
                    Spacer()
                    Text(String(format: "%.2f", source.getBalance()))
                    Text(" lei")
                }
                .onTapGesture {
                    print(index)
                }
                .contextMenu{
                    Button{
                        self.editingSource = source
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
                            delete(source)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions( allowsFullSwipe: false){
                    Button(role: .destructive) {
                        withAnimation {
                            delete(source)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                    Button(){
                        self.editingSource = source
                        showingSourceEditing.toggle()
                    }label: {
                        HStack{
                            Text("Edit your sources")
                            Image(systemName: "pencil.circle")
                        }
                    }
                    .tint(.green)
                })
                .sheet(isPresented: $showingSourceEditing, content: {
                    EditView(editingSource: $editingSource,
                             toggle: {
                                showingSourceEditing.toggle()
                                save()
                            })
                        .presentationDetents([.medium])
                })

            }

            Button{
                addSource()
            }label: {
                HStack{
                    Text("Add new source")
                    Image(systemName: "plus.circle")
                }
            }
            .foregroundStyle(.green)



        }


    }
}

//#Preview {
//    SourcesView(sources: [], delete: {}, editSource: {})
//}
