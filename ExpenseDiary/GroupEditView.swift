//
//  GroupEditView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

struct GroupEditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var groupService: GroupService?
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                
                Button("Submit") {
                    validateAndSaveGroupDetail()
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                groupService = GroupService(moc: moc)
            }
            .navigationTitle("Create Group")
        }
    }
    
    private func validateAndSaveGroupDetail() {
        if !name.isEmpty {
            groupService?.addGroup(name: name, completion: { status, _ in
                if status {
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        GroupEditView()
    }
}
