//
//  GroupInfoView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI
import CoreData

struct GroupInfoView: View {
    
    @State private var persons = [Personal]()
    // TODO: how come this moc is accessible here without injecting this one in the navigation flow in the previous view
    @Environment(\.managedObjectContext) var moc
    @State private var personalService: PersonalService?
    @State private var contentSize: CGSize = .zero
    
    let groupName: String
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PersonalListView(personals: persons,
                                 type: .group,
                                 contentSize: $contentSize,
                                 delete: { personal in
                    personalService?.delete(personal: personal, completion: { isSuccess in
                        if isSuccess {
                            persons = persons.filter { $0.name != personal.name }
                        }
                    })
                })
                    .frame(height: contentSize.height)
                Divider()
                    .padding()
                Spacer()
            }
            .padding()
            .onAppear {
                personalService = PersonalService(moc: moc)
                
                if let persons = personalService?.getPersonals(by: groupName) {
                    self.persons = persons
                }
            }
            .navigationTitle("\(groupName) Info")
        }
    }
}
/*
#Preview {
    GroupInfoView()
}
*/
