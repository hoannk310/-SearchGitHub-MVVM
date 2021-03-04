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
    var stargezersCount = 0
    var language = ""
    var forksCount = 0
    var nameAuthor = ""
    var imgAuthor = ""
    var urlRepo = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case stargezersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
        case owner
        case nameAuthor = "login"
        case imgAuthor = "avatar_url"
        case urlRepo = "html_url"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(fullName, forKey: .fullName)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(stargezersCount, forKey: .stargezersCount)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(forksCount, forKey: .forksCount)
        try container.encodeIfPresent(urlRepo, forKey: .urlRepo)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        container.decodeIfPresent(Int.self, forKey: .id, assignTo: &id)
        container.decodeIfPresent(String.self, forKey: .fullName, assignTo: &fullName)
        container.decodeIfPresent(String.self, forKey: .description, assignTo: &description)
        container.decodeIfPresent(Int.self, forKey: .stargezersCount, assignTo: &stargezersCount)
        container.decodeIfPresent(String.self, forKey: .language, assignTo: &language)
        container.decodeIfPresent(Int.self, forKey: .forksCount, assignTo: &forksCount)
        container.decodeIfPresent(String.self, forKey: .urlRepo, assignTo: &urlRepo)
        let ownerContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        ownerContainer.decodeIfPresent(String.self, forKey: .nameAuthor, assignTo: &nameAuthor)
        ownerContainer.decodeIfPresent(String.self, forKey: .imgAuthor, assignTo: &imgAuthor)
    }
}

extension ItemModel: Equatable {
    static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
