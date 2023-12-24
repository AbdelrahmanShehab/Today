//
//  ReminderListViewController.swift
//  Today
//
//  Created by Abdelrahman Shehab on 24/12/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int,String>
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellConfiguration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
            
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellConfiguration, for: indexPath, item: itemIdentifier)
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

