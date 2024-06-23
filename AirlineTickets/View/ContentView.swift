//
//  ContentView.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import SwiftUI

struct  ContentView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
        TabView {
            Group {
                coordinator.build(page: .airtravel)
                    .tabItem {
                        Image(systemName: "airplane")
                        Text("Авиаперелеты")
                    }
                Hotel()
                    .tabItem {
                            Image(systemName: "bed.double.fill")
                            Text("Отели")
                    }
                Shorter()
                    .tabItem {
                        Image(systemName: "mappin.circle.fill")
                        Text("Короче")
                    }
                Subscriptions()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Подписки")
                    }
                Profile()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
                    }
            }
            .toolbarBackground(.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }

    }
}

//#Preview {
//    ContentView()
//}
