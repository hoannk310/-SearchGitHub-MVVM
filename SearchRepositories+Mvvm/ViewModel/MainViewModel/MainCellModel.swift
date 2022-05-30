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
        return item.localized_name
    }
    
    var description: String {
        return item.roles.joined(separator: ", ")
    }
    
    var subDescription: String {
        return item.primary_attr + " - " + item.attack_type
    }
    
    var primary_attr: String {
        return item.primary_attr
    }
    
    var iconImg: String {
        return "https://api.opendota.com" + item.icon
    }
    
    var backgroundImage: String {
        return "https://api.opendota.com" + item.img
    }
}
