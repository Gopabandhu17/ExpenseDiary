//
//  PersonalListView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

struct PersonalListView: View {
    let personals: [Personal]
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(personals, id: \.self) { personal in
                    HStack {
                        Text(personal.name ?? "")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Text("₹" + String(personal.amount) + ".00")
                            .font(.system(size: 20, weight: .regular))
                    }
                    .tracking(1.0)
                }
            }
        }
    }
}
/*
#Preview {
    PersonalListView()
}
*/
