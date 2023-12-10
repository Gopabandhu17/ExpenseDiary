//
//  HomeView.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI
import CoreData

enum HomePickerType: String, Hashable {
    case personal
    case group
}

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var personalService: PersonalService?
    @State private var groupService: GroupService?
    @State private var personals = [Personal]()
    @State private var groups = [Group]()
    
    @State private var selectedSegment: HomePickerType = .personal
    @State private var showPersonalExpenseEditView = false
    @State private var showGroupExpenseEditView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                headerPickerView
                
                switch selectedSegment {
                case .personal:
                    PersonalListView(personals: personals)
                case .group:
                    GroupListView(groups: groups)
                }
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showPersonalExpenseEditView, onDismiss: {
                if let personals = personalService?.getPersonals() {
                    self.personals = personals
                }
            }, content: {
                PersonalExpenseEditView()
                    .environment(\.managedObjectContext, moc)
            })
            .sheet(isPresented: $showGroupExpenseEditView, onDismiss: {
                if let groups = groupService?.getGroups() {
                    self.groups = groups
                }
            }, content: {
                GroupEditView()
                    .environment(\.managedObjectContext, moc)
            })
            .onAppear {
                personalService = PersonalService(moc: moc)
                groupService = GroupService(moc: moc)
                if let personals = personalService?.getPersonals() {
                    self.personals = personals
                }
                if let groups = groupService?.getGroups() {
                    self.groups = groups
                }
                // TODO: remove this line of code once you done with development
                let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                print(urls[urls.count-1] as URL)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton
                }
            }
        }
    }
}

extension HomeView {
    private var headerPickerView: some View {
        Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
            Text(HomePickerType.personal.rawValue.capitalized)
                .tag(HomePickerType.personal)
            Text(HomePickerType.group.rawValue.capitalized)
                .tag(HomePickerType.group)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.bottom, 24)
    }
    
    private var addButton: some View {
        Button(action: {
            switch selectedSegment {
            case .personal:
                showPersonalExpenseEditView = true
            case .group:
                showGroupExpenseEditView = true
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

#Preview {
    HomeView()
}
