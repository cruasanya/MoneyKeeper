//
//  MainScreenView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var user:User
    @State var selectedView:Int = 0
    var body: some View {
        VStack{
            HeaderView()
                .environmentObject(user)
                .padding(.horizontal)

            switch selectedView {
            case 0:
                HomeView()
                    .environmentObject(user)
            case 1:
                Text("Statistic")
                Spacer()
            case 2:
                Text("User")
                Spacer()
            default:
                Text("to be continue...")
            }
            HStack {
                Spacer()
                TabBarButton(index: 0, iconName: "house.circle", selectedView: $selectedView)
                Spacer()
                TabBarButton(index: 1, iconName: "chart.bar", selectedView: $selectedView)
                Spacer()
                TabBarButton(index: 2, iconName: "person.circle", selectedView: $selectedView)
                Spacer()
            }
            .frame(maxHeight: 100)

        }
    }
}

#Preview {
    MainScreenView()
        .environmentObject(User(name: "Novicov", surname: "Alexandr"))
}

struct TabBarButton: View {
    var index: Int
    var iconName: String
    @Binding var selectedView: Int

    var body: some View {
        Button(action: {
            withAnimation {
                selectedView = index
            }
        }) {
            Image(systemName: selectedView == index ? "\(iconName).fill" : iconName)
                .font(.largeTitle)
                .foregroundColor(selectedView == index ? .green : .gray)

        }
        .frame(width: 40,height: 40)
    }
}

