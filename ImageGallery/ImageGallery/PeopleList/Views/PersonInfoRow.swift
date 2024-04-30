//
//  PersonInfoView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI

struct PersonInfoRow: View {
    
    enum Layout {
        static let ImageSize: CGFloat = 100
        static let ShadowRadius: CGFloat = 6
    }
    
    let person: Person
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: person.imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Layout.ImageSize, height: Layout.ImageSize)
                .clipShape(.circle)
                .shadow(radius: Layout.ShadowRadius)
            
            VStack(alignment: .leading) {
                KeyValueView(key: "Name: ", value: person.name)
                
                KeyValueView(key: "Number: ", value: person.number)
            }
            .padding()
            
            Spacer()
        }
    }
}
