//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by Abdelrahman Shehab on 02/01/2024.
//

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case date
        case notes
        case title
        case time
        
        var imageName: String? {
            switch self {
            case .date: return "calendar.circle"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}