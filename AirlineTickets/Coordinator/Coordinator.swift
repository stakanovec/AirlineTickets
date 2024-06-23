//
//  Coordinator.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 22/06/2024.
//

import SwiftUI

enum Page: String, Identifiable {
    case contentView, airtravel, arrival, hotel, route, weekends, tickets, shorter, subscriptions, profile, chooseTicket, allTickets
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case arrival
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?

    @Published var inputTextDeparture = UserDefaults.standard.string(forKey: "departure") ?? ""
    @Published var inputTextArrival = ""
    @Published var selectedDateDeparture = Date()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .contentView:
            ContentView()
        case .airtravel:
            Airtravel()
        case .arrival:
            Arrival()
        case .route:
            Route()
        case .weekends:
            Weekends()
        case .tickets:
            Tickets()
        case .hotel:
            Hotel()
        case .shorter:
            Shorter()
        case .subscriptions:
            Subscriptions()
        case .profile:
            Profile()
        case .chooseTicket:
            ChooseTickets()
        case .allTickets:
            AllTickets()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .arrival:
            Arrival()
        }
    }
}
