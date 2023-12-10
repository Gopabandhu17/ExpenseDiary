//
//  GroupService.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import Foundation
import CoreData

typealias GroupHandler = (_ status: Bool, _ groups: [Group]) -> Void

final class GroupService {
    private let moc: NSManagedObjectContext
    private var groups = [Group]()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: Add Group
    func addGroup(name: String, completion: GroupHandler) {
        let group = Group(context: moc)
        group.name = name
        group.dateTime = Date()
        
        save { _ in
            groups.append(group)
            completion(true, groups)
        }
    }
    
    // MARK: Fetch Group
    func getGroups() -> [Group]? {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error while fetching personal list: \(error.localizedDescription)")
        }
        return nil
    }
    
    func add(person: Personal, toGroup name: String) {
        // TODO: expecting to get the group object here for sure
        /// as it is already added in the previous screen
        /// will cover all use cases later --------- PENDING
        guard let group = getGroup(with: name) else { return }
        person.group = group
        save { _ in }
    }
    
    func getGroup(with name: String) -> Group? {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", name)
        fetchRequest.predicate = predicate
        
        do {
            let results = try moc.fetch(fetchRequest)
            return results.first
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    // MARK: Save
    private func save(completion: SuccessCompletion) {
        do {
            try moc.save()
            completion(true)
        } catch {
            print("Save Failed With Error: \(error.localizedDescription)")
            completion(false)
        }
    }
}
