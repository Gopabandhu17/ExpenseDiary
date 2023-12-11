//
//  PersonalListView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

struct PersonalListView: View {

    let personals: [Personal]
    let type: HomePickerType
    @Binding var contentSize: CGSize
    let delete: ((_ personal: Personal) -> Void)?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(personals, id: \.self) { personal in
                    let displayDifference = calculateDifference(for: Int(personal.amount))
                    HStack {
                        Text(personal.name ?? "")
                            .font(.system(size: 16, weight: .medium))

                        Spacer()

                        if type == .group {
                            Text(displayDifference)
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(displayDifference.hasPrefix("-") ? .red : .green)
                        }

                        Text("₹" + String(personal.amount) + ".00")
                            .font(.system(size: 20, weight: .regular))
                        
                        if type == .group && displayDifference.hasPrefix("-") {
                            Button {
                                
                            } label: {
                                Image(systemName: "creditcard.circle")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .bold()
                                    .foregroundStyle(Color.orange)
                            }
                        }
                        
                        Button {
                            delete?(personal)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .bold()
                                .foregroundStyle(Color.red)
                        }

                    }
                    .tracking(1.0)
                }
            }
            .overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        /// NOTE: This has to be done because on onAppear the content size is still zero as no item loaded by then
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            contentSize = geo.size
                        }
                    }
                }
            )
        }
    }
    
    private func calculateDifference(for amount: Int) -> String {
        let totalAmount = personals.map { Int($0.amount) }.reduce (0, +) / personals.count
        if totalAmount > amount {
            let difference = totalAmount - amount
            return "-\(difference)"
        } else if totalAmount < amount {
            let difference = amount - totalAmount
            return "+\(difference)"
        } else {
            return "Balanced"
        }
    }
}
/*
#Preview {
    PersonalListView()
}
*/
