//
//  Header.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var user:User
    @State var extend:Bool = true
    var body: some View {
        ZStack{

            VStack(alignment:.leading){
                HStack{
                    Text(user.getInitials())
                        .font(.title3)
                        .frame(width: extend ? 40 : 60 ,height: extend ? 40 : 60)
                        .background(Color(.orange))
                        .clipShape(Circle())
                        .fontDesign(.rounded)
                        .foregroundStyle(Color("text"))
                    HStack{
                        Text("Balance:")
                        Text("\(user.getBalance()) lei")
                    }
                    .padding(.horizontal)
                    .font(extend ? .title3 : .title2)
                    .onLongPressGesture {
                        withAnimation(){
                            extend.toggle()
                        }
                    }
                    Spacer()

                }

                if !extend{
                    Text("Your goals will be displayed here.")
                        .padding(.horizontal)
                        .font(.title3)
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundStyle(.green)
            )
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(User(name: "Alexandr", surname: "Novicov"))
}
