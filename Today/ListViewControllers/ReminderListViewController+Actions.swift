//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Abdelrahman Shehab on 01/01/2024.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressedDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminer(withId: id)
    }
}
