//
//  ChooseTicket.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import SwiftUI

struct ChooseTickets: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel = OffersViewModel()
    @State private var showingCalendar = false
    @State private var showingCalendarDeparture = false
    @State private var selectedDate = Date()
    @State private var showToggle = true
    let circleColors: [Color] = [.red, .blue, .white, .orange, .purple]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, EEEE"
        return formatter
    }()
    
    var body: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                GeometryReader { geometry in
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Button {
                                coordinator.pop()
                            } label: {
                                Image(systemName: "arrow.backward")
                            }
                            VStack {
                                HStack {
                                    TextField("Departure",
                                              text: $coordinator.inputTextDeparture
                                    )
                                    .padding(10)
                                    Button(action: {
                                        swapTextFields()
                                    }) {
                                        Image(systemName: "arrow.up.arrow.down")
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                Divider()
                                    .background(Color.tfpColor)
                                HStack {
                                    TextField("Arrival",
                                              text: $coordinator.inputTextArrival
                                    )
                                    .padding(10)
                                    Button(action: {
                                        coordinator.inputTextArrival = ""
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            HStack {
                                if dateFormatter.string(from: selectedDate) == dateFormatter.string(from: Date()) {
                                    Image(systemName: "plus")
                                    Text("обратно")
                                } else {
                                    Text(dateFormatter.string(from: selectedDate))
                                }
                            }
                            .padding(10)
                            .background(Color.customFillColor)
                            .cornerRadius(30)
                            .onTapGesture {
                                showingCalendar = true
                            }
                            .sheet(isPresented: $showingCalendar) {
                                VStack {
                                    Text("Выберите дату")
                                        .font(.headline)
                                        .padding()
                                    DatePicker(
                                        "Дата",
                                        selection: $selectedDate,
                                        displayedComponents: [.date]
                                    )
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                    Button("Закрыть") {
                                        showingCalendar = false
                                    }
                                    .padding()
                                }
                                .padding()
                            }
                            HStack {
                                Text(dateFormatter.string(from: coordinator.selectedDateDeparture))
                            }
                            .padding(10)
                            .background(Color.customFillColor)
                            .cornerRadius(30)
                            .onTapGesture {
                                showingCalendarDeparture = true
                            }
                            .sheet(isPresented: $showingCalendarDeparture) {
                                VStack {
                                    Text("Выберите дату")
                                        .font(.headline)
                                        .padding()
                                    DatePicker(
                                        "Дата",
                                        selection: $coordinator.selectedDateDeparture,
                                        displayedComponents: [.date]
                                    )
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                    Button("Закрыть") {
                                        showingCalendarDeparture = false
                                    }
                                    .padding()
                                }
                                .padding()
                            }
                            HStack {
                                Image(systemName: "person.fill")
                                Text("1,эконом")
                            }
                            .padding(10)
                            .background(Color.customFillColor)
                            .cornerRadius(30)
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                Text("Фильтр")
                            }
                            .padding(10)
                            .background(Color.customFillColor)
                            .cornerRadius(30)
                        }
                    }
                    VStack {
                        Text("Прямые рейсы")
                            .font(.title3)
                        ForEach(Array(viewModel.ticketOffers.enumerated()), id: \.element.id) { index, ticketOffer in
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(circleColors[index % circleColors.count])
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(ticketOffer.title)")
                                            .font(
                                                Font.custom("SF Pro", size: 14)
                                            )
                                        Spacer()
                                        Text("\(ticketOffer.price.value) ₽")
                                            .foregroundColor(.blue)
                                    }
                                    Text("\(ticketOffer.time_range.joined(separator: ", "))")
                                        .font(
                                            Font.custom("SF Pro", size: 14)
                                        )
                                    Divider()
                                }
                            }
                        }
                        Text("Показать все")
                            .foregroundColor(.blue)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    Button {
                        coordinator.push(.allTickets)
                    } label: {
                        Text("Посмотреть все билеты")
                            .frame(width: geometry.size.width * 0.9)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(Color.blue)
                        Text("Подписка на цену")
                        Toggle("", isOn: $showToggle)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(10)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.loadTicketOffers()
            }
    }
    private func swapTextFields() {
        let temp = coordinator.inputTextDeparture
        coordinator.inputTextDeparture = coordinator.inputTextArrival
        coordinator.inputTextArrival = temp
    }
}

//#Preview {
//    ChooseTicket()
//}
