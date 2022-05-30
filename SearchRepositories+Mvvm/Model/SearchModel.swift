//
//  SearchModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation

struct SearchModel: Codable {
    var totalCount = 0
    var incompleteResults = false
    var items = [ItemModel]()
    
    enum  CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct ItemModel: Codable {
    var id = 0
    var fullName = ""
    var description = ""
    var role: [String] = []
    var legs: Int = 0
    var primary_attr: String = ""
    var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "localized_name"
        case description = "attack_type"
        case role
        case legs
        case primary_attr
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(fullName, forKey: .fullName)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(legs, forKey: .legs)
        try container.encodeIfPresent(primary_attr, forKey: .primary_attr)
        try container.encodeIfPresent(name, forKey: .name)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        container.decodeIfPresent(Int.self, forKey: .id, assignTo: &id)
        container.decodeIfPresent(String.self, forKey: .fullName, assignTo: &fullName)
        container.decodeIfPresent(String.self, forKey: .description, assignTo: &description)
        container.decodeIfPresent(Array.self, forKey: .role, assignTo: &role)
        container.decodeIfPresent(Int.self, forKey: .legs, assignTo: &legs)
        container.decodeIfPresent(String.self, forKey: .primary_attr, assignTo: &primary_attr)
        container.decodeIfPresent(String.self, forKey: .name, assignTo: &name)
    }
}


extension ItemModel: Equatable {
    static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}

