//
//  GroupExpenseEditView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

struct GroupExpenseEditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var amount: String = ""
    
    @State private var personalService: PersonalService?
    @State private var groupService: GroupService?
    
    let groupName: String
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(spacing: 12) {
                    TextField("Participants", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                    TextField("Amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                
                Button("Submit") {
                    validateAndAddPersonal()
                }
                .padding(.top, 24)
                
                Spacer()
            }
            .onAppear {
                personalService = PersonalService(moc: moc)
                groupService = GroupService(moc: moc)
            }
        }
        .padding()
        .navigationTitle("Add Participants")
    }
    
    private func validateAndAddPersonal() {
        if !name.isEmpty,
           let convertedAmout = Int(amount) {
            if let person = personalService?.getPerson(with: name) {
                // add this person to corresponding group table
                groupService?.add(person: person, toGroup: groupName)
                dismiss()
            } else {
                personalService?.addPersonal(name: name, amount: convertedAmout) { status, _ in
                    if status,
                    let person = personalService?.getPerson(with: name) {
                        /// alredy we have inserted the person
                        /// we can expect to get the person here for sure
                        groupService?.add(person: person, toGroup: groupName)
                        dismiss()
                    }
                }
            }
        }
    }
}
/*
#Preview {
    NavigationStack {
        GroupExpenseEditView()
    }
}
 */
