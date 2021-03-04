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
    var database = DataManagerRealm()
    func getAllItem() {
        for item in database.getAllItem() {
            items.value.append(item)
        }
    }
    
}
