//
//  PeopleListViewModel.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import Foundation
import SwiftUI

class PeopleListViewModel: ObservableObject {
    
    @Published var people: [Person] = []
    
    @MainActor
    func addPerson(_ person: Person) {
        people.append(person)
    }
}
