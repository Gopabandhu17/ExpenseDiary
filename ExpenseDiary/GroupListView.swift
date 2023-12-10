//
//  GroupListView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

struct GroupListView: View {
    let groups: [Group]
    @State private var showGroupExpenseEditView = false
    @State private var showGroupInfoView = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(groups, id: \.self) { group in
                    NavigationLink {
                        if let name = group.name {
                            GroupExpenseEditView(groupName: name)
                        }
                    } label: {
                        HStack(spacing: .zero) {
                            Text(group.name ?? "")
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer(minLength: 8)
                            
                            if let date = group.dateTime {
                                let formattedDate = formatDate(date: date, format: "EEEE, MMM d, yyyy HH:mm")
                                Text(formattedDate)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                            NavigationLink {
                                if let name = group.name {
                                    GroupInfoView(groupName: name)
                                }
                            } label: {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .padding(.leading, 16)
                            }
                        }
                        .foregroundStyle(Color.primary)
                        .tracking(1.0)
                    }
                }
            }
        }
    }
    
    private func formatDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
/*
#Preview {
    GroupListView()
}
*/
