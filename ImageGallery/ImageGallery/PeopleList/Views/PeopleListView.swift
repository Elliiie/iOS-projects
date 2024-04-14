//
//  PeopleListView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI
import PhotosUI

struct PeopleListView: View {
    
    @StateObject var viewModel = PeopleListViewModel()
    
    @State var showAddPerson = false
    
    var body: some View {
        VStack {
            List(viewModel.people) { person in
                PersonInfoView(person: person)
            }
            
            Button(action: {
                showAddPerson = true
            }, label: {
                Text("Add person")
                    .padding()
            })
        }
        .popover(isPresented: $showAddPerson, content: {
            CreatePersonView(viewModel: .init(completion: { person in
                viewModel.addPerson(person)
                showAddPerson = false
            }))
        })
    }
}

#Preview {
    PeopleListView()
}
