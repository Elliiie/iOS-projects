//
//  MainButton.swift
//  Memorize
//
//  Created by Elena Georgieva on 2.05.23.
//

import SwiftUI

private struct LayoutConstants {
    static let TextOffset: CGFloat = 8
    static let BackgroundCornerRadius: CGFloat = 12
    static let BackgroundOpacity: CGFloat = 0.3
}

struct MainButton: View {
    
    struct ButtonData {
        var title: String
        var tapHandler: () -> Void
    }
    
    var data: ButtonData
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                data.tapHandler()
            } label: {
                Spacer()
                
                Text(data.title)
                    .font(.title)
                    .padding(LayoutConstants.TextOffset)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: LayoutConstants.BackgroundCornerRadius)
                    .foregroundColor(.gray)
                    .opacity(LayoutConstants.BackgroundOpacity)
            )
        }
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(data: .init(title: "Asdf", tapHandler: {}))
    }
}
