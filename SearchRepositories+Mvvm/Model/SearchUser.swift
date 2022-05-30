//
//  SearchUser.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import Foundation

struct SearchUser: Codable {
    var totalCount = 0
    var incompleteResults = false
    var items = [UserModel]()
    
    enum  CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }

}
struct UserModel: Codable {
    var name = ""
    var avatar = ""
    var team_name = ""
}

extension UserModel: Equatable {
    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.name == rhs.name
    }
}
