//
//  MainCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation
import SwiftUI
import RealmSwift

final class MainCellModel {
    private var item : ItemModel
    var database = DataManagerRealm()
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
    
    func favoImage() -> UIImage {
        if database.getAllItem().contains(where: {$0.id == item.id}) {
            return UIImage(systemName: "star.fill") ?? UIImage()
        }
        return UIImage(systemName: "star") ?? UIImage()
    }
}
