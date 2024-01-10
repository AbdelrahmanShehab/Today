//
//  ReminderStore.swift
//  Today
//
//  Created by Abdelrahman Shehab on 10/01/2024.
//

import Foundation
import EventKit

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        switch status {
        case.authorized:
            return
        case .restricted:
            throw TodayError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {
                throw TodayError.accessDenied
            }
        case .denied:
            throw TodayError.accessDenied
        @unknown default:
            throw TodayError.unknown
        }
    }
    func readAll() async throws -> [Reminder]{
        guard isAvailable else {
            throw TodayError.accessDenied
        }
        
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekreminders = try await ekStore.reminders(matching: predicate)
        let reminders: [Reminder] = try ekreminders.compactMap { ekreminder in
            do {
                return try Reminder(with: ekreminder)
            } catch TodayError.reminderHasNoDueDate{
                return nil
            }
        }
        return reminders
    }
}
