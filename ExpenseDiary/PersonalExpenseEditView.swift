//
//  PersonalExpenseEditView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI
import CoreData

struct PersonalExpenseEditView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var personalService: PersonalService?
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var amount: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Submit") {
                    validateAndSavePersonalExpenseDetail()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Individual Expenses")
        }
        .onAppear {
            personalService = PersonalService(moc: moc)
        }
    }
    
    private func validateAndSavePersonalExpenseDetail() {
        if !name.isEmpty,
           let convertedAmount = Int(amount),
           !amount.isEmpty {
            personalService?.addPersonal(name: name, amount: convertedAmount) { status, _ in
                if status {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PersonalExpenseEditView()
    }
}
