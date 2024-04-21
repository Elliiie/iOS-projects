//
//  PeopleListView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PeopleListView: View {
    
    @StateObject var viewModel: PeopleListViewModel
        
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: PeopleListViewModel(modelContext: modelContext))
    }
    
    @State var showAddPerson = false
    @State var showEditPerson = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.people) { person in
                    NavigationLink {
                        PersonInfoView(person: person)
                    } label: {
                        PersonInfoRow(person: person)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deletePerson(person)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    viewModel.selectedPerson = person
                                    showEditPerson.toggle()
                                } label: {
                                    Label("Edit", systemImage: "pencil.circle")
                                }
                            }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("People")
            .toolbar {
                Button {
                    showAddPerson = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .popover(isPresented: $showAddPerson, content: {
                CreatePersonView(viewModel: .init(mode: .create, completion: { person in
                    viewModel.addPerson(person)
                    showAddPerson = false
                }))
            })
            .popover(isPresented: $showEditPerson, content: {
                if let selectedPerson = viewModel.selectedPerson {
                    CreatePersonView(viewModel: .init(mode: .edit(selectedPerson), completion: { person in
                        
                    }))
                }
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
