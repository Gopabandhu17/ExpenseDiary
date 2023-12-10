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
    
    let groupName: String
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PersonalListView(personals: persons)
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
