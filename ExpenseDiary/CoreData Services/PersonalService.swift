//
//  PersonalService.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import Foundation
import CoreData

typealias PersonalHandler = (_ status: Bool, _ personals: [Personal]) -> Void
typealias SuccessCompletion = (_ isSuccess: Bool) -> Void

final class PersonalService {
    private let moc: NSManagedObjectContext
    private var personals = [Personal]()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: Add Personal Expense
    func addPersonal(name: String, amount: Int, completion: PersonalHandler) {
        let personal = Personal(context: moc)
        personal.name = name
        personal.amount = Int64(amount)
        
        save { _ in
            personals.append(personal)
            completion(true, personals)
        }
    }
    
    // MARK: Fetch Personal Expense
    func getPersonals(by groupName: String? = nil) -> [Personal]? {
        let fetchRequest: NSFetchRequest<Personal> = Personal.fetchRequest()
        if let groupName = groupName {
            let predicate = NSPredicate(format: "group.name = %@", groupName)
            fetchRequest.predicate = predicate
        }
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error while fetching personal list: \(error.localizedDescription)")
        }
        return nil
    }
    
    func getPerson(with name: String) -> Personal? {
        let fetchRequest: NSFetchRequest<Personal> = Personal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            return try moc.fetch(fetchRequest).first
        } catch {
            print("Error while fetching personal list: \(error.localizedDescription)")
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
