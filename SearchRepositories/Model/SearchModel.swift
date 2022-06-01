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
    var name = ""
    var localized_name = ""
    var primary_attr: String = ""
    var attack_type: String = ""
    var roles: [String] = []
    var img: String = ""
    var icon: String = ""
    var base_health: Int = 0
    var base_health_regen: Double = 0.0
    var base_mana: Int = 75
    var base_mana_regen: Int = 0
    var base_armor: Int = 0
    var base_mr: Int = 0
    var base_attack_min: Int = 0
    var base_attack_max: Int = 0
    var base_str: Int = 0
    var base_agi: Int = 0
    var base_int: Int = 0
    var str_gain: Double = 0.0
    var agi_gain: Double = 0.0
    var int_gain: Double = 0.0
    var attack_range: Int = 0
    var projectile_speed: Int = 0
    var attack_rate: Double = 0.0
    var move_speed: Int = 0
}


extension ItemModel: Equatable {
    static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}

