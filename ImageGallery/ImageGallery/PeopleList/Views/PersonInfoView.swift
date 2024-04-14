//
//  PersonInfoView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI

struct PersonInfoView: View {
    
    let person: Person
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: person.imageData) ?? UIImage())
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .shadow(radius: 6)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Name: ")
                        .bold()
                    
                    Text(person.name)
                }
                
                HStack {
                    Text("Number: ")
                        .bold()
                    
                    Text(person.number)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}
