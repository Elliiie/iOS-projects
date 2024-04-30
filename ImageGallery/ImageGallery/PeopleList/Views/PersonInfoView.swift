//
//  PersonInfoView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 21.04.24.
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

struct PersonInfoView: View {
    
    let person: Person
    let onAppearHandler: () -> Void
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: person.imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(.circle)
                .shadow(radius: 6)
            
            Spacer()
                .frame(height: 32)
            
            VStack(alignment: .leading) {
                KeyValueView(key: "Name: ", value: person.name)
                
                Divider()
                
                KeyValueView(key: "Number: ", value: person.number)
                
                Divider()
                                
                KeyValueView(key: "Birthdate: ", value: person.birthdate.formatted())
                
                Divider()
                
                KeyValueView(key: "Added on:", value: person.creationDate.formatted())
                
                Divider()
                
                KeyValueView(key: "Clicked: ", value: "\(person.clickedCount) times")
                
            }
            .padding()
            .background(content: {
                Color.clear
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(radius: 5)
            })
        }
        .padding()
        .onAppear {
            onAppearHandler()
        }
    }
}
