//
//  Header.swift
//  MoneyKeeper
//
//  Created by Александр Новиков on 13.11.2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Color("header"))
                .frame(width: 600, height: 300)
        }
    }
}

#Preview {
    HeaderView()
}
