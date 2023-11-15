//
//  ContentView.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var user:User = User(name: "Alexandr", surname: "Novicov")
    var body: some View {
        MainScreenView()
            .environmentObject(user)
    }
}

#Preview {
    ContentView()
}
