//
//  EditView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 15.11.2023.
//

import SwiftUI

struct EditView: View {
    @State var editingText:String = ""
    var editingSource : Source
    var toggle: ()->Void
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                Text("Edit your \(editingSource.getName()) balance:")
                    .font(.system(size:24))
                    .fontWeight(.semibold)
                    .font(.footnote)


                TextField("\( String(format: "%.2f",editingSource.getBalance()))",text: $editingText)
                        .font(.system(size:20))
                Divider()
            }

            Button{
                guard let actualBalance = Double(editingText) else {return}
                editingSource.changeBalance(by: actualBalance)
                toggle()
            }label: {
                HStack{
                    Text("Change")
                    Image(systemName: "checkmark.circle")
                }
                .frame(width: 350, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(.green)
                )
            }
            .buttonStyle(.plain)

        }
        .padding(.horizontal)
    }
}

#Preview {
    EditView(editingSource: Source(name: "Card", balance: 0, iconName: "creditcard"), toggle: {})
}
