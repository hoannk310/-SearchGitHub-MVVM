//
//  FavoriteCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import Foundation

final class FavoriteCellModel {
    private var item : Favorite
    init(item: Favorite
    ) {
        self.item = item
    }
    
    var fullName: String {
        return item.fullName
    }
    
    var description: String {
        return item.description
    }
    
    var subDescription: String {
        return String(format: kSubDescription, item.language,"\(item.stargezersCount)","\(item.forksCount)")
    }
}
