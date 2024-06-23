//
//  Hotel.swift
//  AirlineTickets
//
//  Created by Aliaksei Schyslionak on 20/06/2024.
//

import SwiftUI

struct Hotel: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Text("Hotel")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    Hotel()
}
