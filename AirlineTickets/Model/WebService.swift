//
//  WebService.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 21/06/2024.
//

import SwiftUI
import Combine

class OffersViewModel: ObservableObject {
    
    @Published var offers: [Offer] = []
    @Published var ticketOffers: [TicketOffer] = []
    @Published var tickets: [Ticket] = []
    
    func loadOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/ad9a46ba-276c-4a81-88a6-c068e51cce3a") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: OffersResponse.self, decoder: JSONDecoder())
            .map { $0.offers }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$offers)
    }
    
    func loadTicketOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/38b5205d-1a3d-4c2f-9d77-2f9d1ef01a4a") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketsOffersResponse.self, decoder: JSONDecoder())
            .map { $0.tickets_offers }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$ticketOffers)
    }
    
    func loadTickets() {
        guard let url = URL(string: "https://run.mocky.io/v3/c0464573-5a13-45c9-89f8-717436748b69") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketsResponse.self, decoder: JSONDecoder())
            .map { $0.tickets }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$tickets)
    }
}
