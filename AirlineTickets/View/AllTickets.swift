//
//  AllTickets.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 21/06/2024.
//

import SwiftUI

struct AllTickets: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel = OffersViewModel()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
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
                    VStack(alignment: .leading)  {
                        HStack {
                            Button {
                                coordinator.pop()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .padding()
                            }
                            VStack(alignment: .leading) {
                                Text("\(coordinator.inputTextDeparture) - \(coordinator.inputTextArrival)")
                                Text(timeFormatter.string(from: coordinator.selectedDateDeparture))
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                    .background(Color.customFillColor)
                    .cornerRadius(0)
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.tickets) { tickets in
                            VStack(alignment: .leading) {
                                    if tickets.badge != nil {
                                        Text(tickets.badge ?? "")
                                        .padding(4)
                                        .background(.blue)
                                        .cornerRadius(10)
                                        .offset(y: -15)
                                }
                                Text("\(tickets.price.value) ₽")
                                HStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.red)
                                    VStack {
                                        HStack {
                                            if let departureDate = dateStringToDate(tickets.departure.date), let arrivalDate = dateStringToDate(tickets.arrival.date) {
                                                let timeDifference = differenceInHoursBetween(departureDate, arrivalDate)
                                                let formattedDifference = String(format: "%.1f", timeDifference )
                                                Text("\(dateFormatter.string(from: departureDate)) - \(dateFormatter.string(from: arrivalDate)) \(formattedDifference)ч в пути")
                                                    .font(
                                                        Font.custom("SF Pro", size: 14)
                                                    )
                                            }
                                            if tickets.hasTransfer == false {
                                                Text("/  Без пересадок")
                                                    .font(
                                                        Font.custom("SF Pro", size: 14)
                                                    )
                                            }
                                            Spacer()
                                        }
                                        HStack {
                                            Text(tickets.departure.airport)
                                                .font(
                                                    Font.custom("SF Pro", size: 14)
                                                )
                                            Text(tickets.arrival.airport)
                                                .font(
                                                    Font.custom("SF Pro", size: 14)
                                                )
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .frame(width: geometry.size.width * 0.9)
                            .padding()
                            .background(Color.customFillColor)
                            .cornerRadius(10)
                        }
                    }
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                        Text("Фильтр")
                        Image(systemName: "chart.bar.fill")
                        Text("График цен")
                    }
                    .frame(width: geometry.size.width * 0.7)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.loadTickets()
        }
    }
    func dateStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    func differenceInHoursBetween(_ departureDate: Date, _ arrivalDate: Date) -> Double {
        let differenceInSeconds = arrivalDate.timeIntervalSince(departureDate)
        let differenceInHalfHours = (differenceInSeconds / 1800).rounded() * 0.5
        return differenceInHalfHours
    }
}

