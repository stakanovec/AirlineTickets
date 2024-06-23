//
//  Hotels.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import SwiftUI

struct Airtravel: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = OffersViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var promptDeparture = "Откуда - Москва"
    @State private var prompt = "Куда - Турция"
    @State private var arrival = ""
    @State private var letters = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    @State private var isArrivalSheetPresented = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    Text("Поиск дешевых авиабилетов")
                        .foregroundColor(Color.mainTextColor)
                        .font(
                            Font.custom("SF Pro", size: 24)
                        )
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.horizontal)
                                .foregroundColor(Color.tfpColor)
                            VStack {
                                TextField("Departure",
                                          text: $coordinator.inputTextDeparture,
                                          prompt: Text(promptDeparture)
                                    .foregroundColor(Color.white)
                                )
                                .onChange(of: coordinator.inputTextDeparture) {
                                    let filtered = coordinator.inputTextDeparture.filter { letters.contains($0) }
                                    if filtered != coordinator.inputTextDeparture { self.coordinator.inputTextDeparture = filtered }
                                    UserDefaults.standard.set(filtered, forKey: "departure")
                                }
                                Divider()
                                    .background(Color.tfpColor)
                                TextField("Arrival",
                                          text: $arrival,
                                          prompt: Text(prompt)
                                    .foregroundColor(Color.tfpColor)
                                )
                                .focused($isTextFieldFocused)
                                .onChange(of: isTextFieldFocused) {
                                    if !coordinator.inputTextDeparture.isEmpty && isTextFieldFocused {
                                        coordinator.present(sheet: .arrival)
                                        isTextFieldFocused = false
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.tfColor)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("Музыкально отлететь")
                            .foregroundColor(Color.white)
                            .font(
                                Font.custom("SF Pro", size: 22)
                            )
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.offers) { offer in
                                    VStack(alignment: .leading) {
                                        Image("\(offer.id)")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .cornerRadius(10)
                                        Text("\(offer.title)")
                                            .foregroundColor(Color.white)
                                        Text("\(offer.town)")
                                            .foregroundColor(Color.white)
                                        HStack {
                                            Image(systemName: "airplane")
                                                .foregroundColor(Color.white)
                                            Text("от \(offer.price.value) ₽")
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .task {
            viewModel.loadOffers()
        }
    }
}



