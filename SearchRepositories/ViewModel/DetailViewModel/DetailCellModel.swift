//
//  DetailCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/3/21.
//

import Foundation

final class DetailCellModel {
    
    private var item: ItemModel
    init(item: ItemModel) {
        self.item = item
    }
    
    var fullName: String {
        return item.localized_name
    }
    
    var description: String {
        return item.roles.joined(separator: ", ")
    }
    
    var subDescription: String {
        return item.name
    }
}
