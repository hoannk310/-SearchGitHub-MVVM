//
//  FavoriteModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id: Int  = 0
    @objc dynamic var fullName: String = ""
    @objc dynamic var descrip: String = ""
    @objc dynamic var stargezersCount: Int = 0
    @objc dynamic var language: String = ""
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var nameAuthor: String = ""
    @objc dynamic var urlRepo: String = ""
    
}
