//
//  SearchCellModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import Foundation

final class SearchCellModel {
    private var item : UserModel
    init(item: UserModel) {
        self.item = item
    }
    
    var name: String {
        return item.name
    }
    
    var image: String {
        return item.avatar
    }
    
    var team: String {
        return "Team: " + item.team_name
    }
}
