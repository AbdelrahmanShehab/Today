//
//  ReminderListViewController.swift
//  Today
//
//  Created by Abdelrahman Shehab on 24/12/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = SnapShot()
        snapShot.appendSections([0])
        snapShot.appendItems(Reminder.sampleData.map({ $0.title }))
        dataSource.apply(snapShot)
        collectionView.dataSource = dataSource
        
    }


    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

