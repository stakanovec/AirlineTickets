//
//  PostModel.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import Foundation

struct Offer: Decodable, Identifiable {
  let id: Int
  let title: String
  let town: String
  let price: Price
}

struct Price: Decodable {
  let value: Int
}

struct OffersResponse: Decodable {
    let offers: [Offer]
}

struct TicketOffer: Identifiable, Decodable {
    let id: Int
    let title: String
    let time_range: [String]
    let price: PriceTickets
}

struct PriceTickets: Decodable {
  let value: Int
}

struct TicketsOffersResponse: Decodable {
    let tickets_offers: [TicketOffer]
}

struct TicketsResponse: Decodable {
    let tickets: [Ticket]
}

struct Ticket: Decodable, Identifiable {
    let id: Int
    let badge: String?
    let price: PriceTicket
    let providerName: String
    let company: String
    let departure: FlightDetail
    let arrival: FlightDetailarrival
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage?
    let handLuggage: HandLuggage
    let isReturnable: Bool
    let isExchangable: Bool

    enum CodingKeys: String, CodingKey {
        case id, badge, price, company, departure, arrival, luggage
        case providerName = "provider_name"
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

struct PriceTicket: Decodable {
    let value: Int
}

struct FlightDetail: Decodable {
    let town: String
    let date: String
    let airport: String
}

struct FlightDetailarrival: Decodable {
    let town: String
    let date: String
    let airport: String
}

struct Luggage: Decodable {
    let has_luggage: Bool
    let price: PriceLuggage?
}

struct HandLuggage: Decodable {
    let has_hand_luggage: Bool
    let size: String?
}

struct PriceLuggage: Decodable {
    let value: Int
}
