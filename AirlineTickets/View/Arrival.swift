//
//  Arrival.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import SwiftUI

struct Arrival: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var promptArrival = "Куда - Турция"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.bgColorList.ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.tfpColor)
                            Text(coordinator.inputTextDeparture)
                        }
                        Divider()
                            .background(Color.tfpColor)
                        HStack {
                            Image(systemName: "airplane")
                                .foregroundColor(Color.tfpColor)
                            TextField("Arrival",
                                      text: $coordinator.inputTextArrival,
                                      prompt: Text(promptArrival)
                                .foregroundColor(Color.tfpColor)
                            )
                            .padding(5)
                            .onChange(of: coordinator.inputTextArrival) {
                                if !coordinator.inputTextArrival.isEmpty {
                                    coordinator.dismissSheet()
                                    coordinator.push(.chooseTicket)
                                }
                            }
                            if !coordinator.inputTextArrival.isEmpty {
                                Button(action: {
                                    coordinator.inputTextArrival = ""
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    HStack(alignment: .top) {
                        VStack {
                            Button {
                                coordinator.dismissSheet()
                                coordinator.push(.route)
                            } label: {
                                Image("icon_1")
                            }
                            Text("Сложный маршрут")
                                .lineLimit(2)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                )
                        }
                        .padding()
                        VStack {
                            Button {
                                coordinator.inputTextArrival = "Куда угодно"
                            } label: {
                                Image("icon_2")
                            }
                            Text("Куда угодно")
                                .lineLimit(2)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                )
                        }
                        .padding()
                        VStack {
                            Button {
                                coordinator.dismissSheet()
                                coordinator.push(.weekends)
                            } label: {
                                Image("icon_3")
                            }
                            Text("Выходные")
                                .lineLimit(2)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                )
                        }
                        .padding()
                        VStack {
                            Button {
                                coordinator.dismissSheet()
                                coordinator.push(.tickets)
                            } label: {
                                Image("icon_4")
                            }
                            Text("Горячие билеты")
                                .lineLimit(2)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                )
                        }
                        .padding()
                    }
                    VStack {
                        Button{
                            coordinator.inputTextArrival = "Стамбул"
                        } label: {
                            HStack {
                                Image("icon_7")
                                VStack(alignment: .leading) {
                                    Text("Стамбул")
                                        .foregroundColor(Color.white)
                                    Text("Популярное направление")
                                        .foregroundColor(Color.gray)
                                        .font(
                                            Font.custom("SF Pro", size: 12)
                                        )
                                }
                                Spacer()
                            }
                        }
                        Divider()
                        Button{
                            coordinator.inputTextArrival = "Пхукет"
                        } label: {
                            HStack {
                                Image("icon_6")
                                VStack(alignment: .leading) {
                                    Text("Пхукет")
                                        .foregroundColor(Color.white)
                                    Text("Популярное направление")
                                        .foregroundColor(Color.gray)
                                        .font(
                                            Font.custom("SF Pro", size: 12)
                                        )
                                }
                                Spacer()
                            }
                        }
                        Divider()
                        Button{
                            coordinator.inputTextArrival = "Сочи"
                        } label: {
                            HStack {
                                Image("icon_5")
                                VStack(alignment: .leading) {
                                    Text("Сочи")
                                        .foregroundColor(Color.white)
                                    Text("Популярное направление")
                                        .foregroundColor(Color.gray)
                                        .font(
                                            Font.custom("SF Pro", size: 12)
                                        )
                                }
                                Spacer()
                            }
                        }
                        Divider()
                    }
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    Spacer()
            }
        }
    }
}

