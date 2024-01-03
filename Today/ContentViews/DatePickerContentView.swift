//
//  DatePickerContentView.swift
//  Today
//
//  Created by Abdelrahman Shehab on 03/01/2024.
//

import UIKit

class DatePickerContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var date = Date.now
        
        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }
    }
    var configuration: UIContentConfiguration {
        didSet {
            
        }
    }
    
    let datePicker = UIDatePicker()
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        return DatePickerContentView.Configuration()
    }
}
