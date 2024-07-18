//
//  View+Extension.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func cornerRadiusAndShadow() -> some View {
        self
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: Layout.CornerRadius))
            .shadow(radius: Layout.ShadowRadius)
    }
}
