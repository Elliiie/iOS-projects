//
//  CarInfoView.swift
//  CarsLib
//
//  Created by Elena Georgieva on 16.05.24.
//

import SwiftUI

struct KeyValueView: View {
    
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
                .bold()
            
            Text(value)
        }
    }
}

struct CarInfoView: View {
    
    let car: Car
    let onAppearHandler: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            KeyValueView(key: "Brand:", value: car.brand)
            
            KeyValueView(key: "Model:", value: car.model)
            
            KeyValueView(key: "Production date:", value: car.productionYear.formatted(date: .abbreviated, time: .omitted))
            
            KeyValueView(key: "Power:", value: car.power.formatted())
            
            KeyValueView(key: "Tapped:", value: "\(car.clickedCount) times")
        }
        .padding()
        .onAppear {
            onAppearHandler()
        }
    }
}
