//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Abdelrahman Shehab on 01/01/2024.
//

import UIKit

extension ReminderListViewController {
    
    @objc func eventStoreChanged(_ notification: NSNotification) {
        reminderStoreChanged()
    }
    
    @objc func didPressedDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminer(withId: id)
    }
    
    @objc func didPressedAddButton(_ sender: UIBarButtonItem) {
        let remindr = Reminder(title: "", dueDate: Date.now)
        let viewController = ReminderViewController(reminder: remindr) { [weak self] remindr in
            self?.addReminder(remindr)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        viewController.isAddingNewReminder = true
        viewController.setEditing(true, animated: true)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancleAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString(
            "Add Reminder", comment: "Add Reminder view controller title")
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    @objc func didCancleAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func didChangeListStyle(_ sender: UISegmentedControl) {
        listStyle = ReminderListStyle(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
        refreshBackground()
    }
}
