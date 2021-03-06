//
//  FavoriteViewModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import Foundation
import RealmSwift
class FavoriteViewModel {
    var items: Box<[Favorite]> = Box([])
    var searchItems: Box<[Favorite]> = Box([])
    var database = DataManagerRealm()
    var count = 0
    func getAllItem() {
        for item in database.getAllItem() {
            items.value.append(item)
        }
    }
    
    func deleteItem(item: Favorite, index: Int) {
        database.deleteItemFromDB(object: item)
        items.value.remove(at: index)
        AppUtil.createNotification(title: "Delete item", body: "Has been delete item", time: 0.1, identifier: "DeleteItem")
    }
    
    func deleteAll() {
        database.deleteAllFromDB()
        items.value.removeAll()
    }
    
    func addItem (itemsFavo: [Favorite]) {
        guard self.database.getAllItem().count != 0 else {
            return
        }
            for item in self.database.getAllItem() {
                for itemFavo in itemsFavo {
                    if itemFavo.id == item.id {
                        self.count += 1
                    }
                }
                if self.count == 0 {
                    self.items.value.insert(item, at: 0)
                } else {
                    self.count = 0
                }
            }
    }
    
    func searchItem (text: String) {
        
        searchItems.value.removeAll()
        guard !text.isEmpty else {
            return
        }
        
        for item in self.database.getAllItem() {
            if item.fullName.contains(text) {
                searchItems.value.append(item)
            }
        }
    }
    
    func sortItemAZ() {
        items.value.removeAll()
        let sortItem = database.getAllItem().sorted { (name1, name2) -> Bool in
            return name1.fullName < name2.fullName
        }
        for item in sortItem {
            items.value.append(item)
        }
    }
    
    func sortItemZA() {
        items.value.removeAll()
        let sortItem = database.getAllItem().sorted { (name1, name2) -> Bool in
            return name1.fullName > name2.fullName
        }
        for item in sortItem {
            items.value.append(item)
        }
    }
}
