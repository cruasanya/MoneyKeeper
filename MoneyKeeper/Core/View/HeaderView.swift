//
//  Header.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var user:User
    var body: some View {
        ZStack{

            VStack(alignment:.leading){
                HStack{
                    Text(user.getInitials())
                        .font(.title3)
                        .frame(width: 40,height: 40)
                        .background(Color(.orange))
                        .clipShape(Circle())
                        .fontDesign(.rounded)
                        .foregroundStyle(Color("text"))
                    HStack{
                        Text("Balance:")
                        Text("\(user.getBalance()) lei")
                    }
                    .padding(.horizontal)
                    .font(.title3)
                    Spacer()

                }.padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20.0)
                            .foregroundStyle(.green)
                    )

            }
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(User(name: "Alexandr", surname: "Novicov"))
}
