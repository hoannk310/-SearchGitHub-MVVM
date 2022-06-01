//
//  ItemsListViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Tuấn Anh Nguyễn on 31/05/2022.
//

import UIKit

class ItemsListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var itemsList: [ItemDotaModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadData()
    }
    
    private func setUpView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemsListCell", bundle: nil), forCellWithReuseIdentifier: "ItemsListCell")
    }
    
    private func loadData() {
        let items = JsonDatabaseHelper.getItemsList(jsonDict: JsonDatabaseHelper.loadJsonData(fileType: .items))
        itemsList = items.itemsDota
    }
}

extension ItemsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.size.width / 3 - 10,
            height: collectionView.bounds.size.width / 3 - 10
        )
    }
}

extension ItemsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsListCell", for: indexPath) as! ItemsListCell
        cell.setUpData(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = itemsList[indexPath.row]
        let itemDetail = ItemDetailViewController(nibName: "ItemDetailViewController", bundle: nil)
        itemDetail.item = item
        self.navigationController?.pushViewController(itemDetail, animated: true)
    }
}

extension ItemsListViewController {
    
    //    private func
}
