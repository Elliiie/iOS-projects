//
//  PeopleListViewModel.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import Foundation
import SwiftUI
import SwiftData

class PeopleListViewModel: ObservableObject {
    
    @Published var people: [Person] = []
    @Published var selectedPerson: Person?
    
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func onAppear() {
        fetchData()
    }
    
    @MainActor
    func addPerson(_ person: Person) {
        people.append(person)
        
        modelContext.insert(person)
    }
    
    func deletePerson(_ person: Person) {
        modelContext.delete(person)
    }
    
    private func fetchData() {
        do {
            let descriptor = FetchDescriptor<Person>(sortBy: [SortDescriptor(\.name)])
            people = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
