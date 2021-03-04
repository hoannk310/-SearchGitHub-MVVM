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
    var image = ""
    var url = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case image = "avatar_url"
        case url = "html_url"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(url, forKey: .url)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        container.decodeIfPresent(String.self, forKey: .name, assignTo: &name)
        container.decodeIfPresent(String.self, forKey: .image, assignTo: &image)
        container.decodeIfPresent(String.self, forKey: .url, assignTo: &url)
     
    }
    
}

extension UserModel: Equatable {
    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.name == rhs.name
    }
}
