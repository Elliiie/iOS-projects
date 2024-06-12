//
//  FiltersView.swift
//  CarsLib
//
//  Created by Elena Georgieva on 11.06.24.
//

import SwiftUI

struct FiltersView: View {
    
    enum Filter {
        case power(String)
        case productionYear(String)
    }
    
    @State var powerTapped: Bool = false
    @State var power: String = ""
    
    @State var productionYearTapped: Bool = false
    @State var productionYear: String = ""
    
    private let completion: (Filter) -> Void
    
    init(completion: @escaping (Filter) -> Void) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button("Done") {
                        complete()
                    }
                    .disabled(!(powerTapped && !power.isEmpty) && !(productionYearTapped && !productionYear.isEmpty))
                    .padding()
                }
                
                HStack {
                    Text("Power")
                    
                    Spacer()
                    
                    if powerTapped {
                        Image(systemName: "checkmark")
                    }
                }
                .padding()
                .onTapGesture {
                    powerTapped.toggle()
                    
                    if productionYearTapped {
                        productionYearTapped.toggle()
                    }
                }
                
                if powerTapped {
                    TextField("Power", text: $power)
                        .keyboardType(.decimalPad)
                        .padding()
                }
                
                HStack {
                    Text("Production year")
                    
                    Spacer()
                    
                    if productionYearTapped {
                        Image(systemName: "checkmark")
                    }
                }
                .padding()
                .onTapGesture {
                    productionYearTapped.toggle()
                    
                    if powerTapped {
                        powerTapped.toggle()
                    }
                }
                
                if productionYearTapped {
                    TextField("Production year", text: $productionYear)
                        .keyboardType(.decimalPad)
                        .padding()
                }
            }
        }
    }
    
    private func complete() {
        if productionYearTapped {
            completion(.productionYear(productionYear))
        }
        
        if powerTapped {
            completion(.power(power))
        }
    }
}
