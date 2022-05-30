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
    var role = List<String>()
    @objc dynamic var legs: Int = 0
    @objc dynamic var primary_attr: String = ""
    @objc dynamic var name: String = ""
    
    init(id: Int, fullName: String, descrip: String, role: [String], legs: Int, primary_attr: String, name: String) {
        self.id = id
        self.fullName = fullName
        self.descrip = descrip
        self.role.append(objectsIn: role)
        self.legs = legs
        self.primary_attr = primary_attr
        self.name = name
    }
    override init(){}
    
}
