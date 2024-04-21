//
//  PersonInfoView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI

struct PersonInfoRow: View {
    
    let person: Person
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: person.imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .shadow(radius: 6)
            
            VStack(alignment: .leading) {
                KeyValueView(key: "Name: ", value: person.name)
                
                KeyValueView(key: "Number: ", value: person.number)
            }
            .padding()
            
            Spacer()
        }
    }
}
