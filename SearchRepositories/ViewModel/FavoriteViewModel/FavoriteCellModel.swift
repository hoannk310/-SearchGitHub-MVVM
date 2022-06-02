//
//  FavoriteCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import Foundation
import UIKit

final class FavoriteCellModel {
    private var item : Favorite
    init(item: Favorite
    ) {
        self.item = item
    }
    
    var fullName: String {
        return item.localized_name
    }
    
    var description: String {
        return item.role.joined(separator: ", ")
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
