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
    
    enum Layout {
        static let ImageSize: CGFloat = 200
        static let ShadowRadius: CGFloat = 6
        static let ImageTextSpace: CGFloat = 32
        static let CornerRadius: CGFloat = 14
    }
    
    let person: Person
    let onAppearHandler: () -> Void
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: person.imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Layout.ImageSize, height: Layout.ImageSize)
                .clipShape(.circle)
                .shadow(radius: Layout.ShadowRadius)
            
            Spacer()
                .frame(height: Layout.ImageTextSpace)
            
            VStack(alignment: .leading) {
                KeyValueView(key: "Name: ", value: person.name)
                
                Divider()
                
                KeyValueView(key: "Number: ", value: person.number)
                
                Divider()
                                
                KeyValueView(key: "Birthdate: ", value: person.birthdate.formatted(date: .abbreviated, time: .omitted))
                
                Divider()
                
                KeyValueView(key: "Added on:", value: person.creationDate.formatted())
                
                Divider()
                
                KeyValueView(key: "Clicked: ", value: "\(person.clickedCount) times")
                
            }
            .padding()
            .background(content: {
                Color.clear
                    .clipShape(RoundedRectangle(cornerRadius: Layout.CornerRadius))
                    .shadow(radius: Layout.ShadowRadius)
            })
        }
        .padding()
        .onAppear {
            onAppearHandler()
        }
    }
}
