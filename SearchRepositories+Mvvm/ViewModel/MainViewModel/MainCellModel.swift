//
//  MainCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation

final class MainCellModel {
    private var item : ItemModel
    init(item: ItemModel) {
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
