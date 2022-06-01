//
//  FavoriteModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var localized_name = ""
    @objc dynamic var primary_attr: String = ""
    @objc dynamic var attack_type: String = ""
    var role = List<String>()
    @objc dynamic var img: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var base_health: Int = 0
    @objc dynamic var base_health_regen: Double = 0.0
    @objc dynamic var base_mana: Int = 75
    @objc dynamic var base_mana_regen: Int = 0
    @objc dynamic var base_armor: Int = 0
    @objc dynamic var base_mr: Int = 0
    @objc dynamic var base_attack_min: Int = 0
    @objc dynamic var base_attack_max: Int = 0
    @objc dynamic var base_str: Int = 0
    @objc dynamic var base_agi: Int = 0
    @objc dynamic var base_int: Int = 0
    @objc dynamic var str_gain: Double = 0.0
    @objc dynamic var agi_gain: Double = 0.0
    @objc dynamic var int_gain: Double = 0.0
    @objc dynamic var attack_range: Int = 0
    @objc dynamic var projectile_speed: Int = 0
    @objc dynamic var attack_rate: Double = 0.0
    @objc dynamic var move_speed: Int = 0
    
    init(id: Int, name: String,
         localized_name: String,
         primary_attr: String,
         attack_type: String,
         role: [String],
         img: String,
         icon: String,
         base_health: Int,
         base_health_regen: Double,
         base_mana: Int,
         base_mana_regen: Int,
         base_armor: Int, base_mr: Int,
         base_attack_min: Int,
         base_attack_max: Int,
         base_str: Int,
         base_agi: Int,
         base_int: Int,
         str_gain: Double,
         agi_gain: Double,
         int_gain: Double,
         attack_range: Int,
         projectile_speed: Int,
         attack_rate: Double,
         move_speed: Int) {
        self.role.append(objectsIn: role)
        self.id = id
        self.name = name
        self.localized_name = localized_name
        self.primary_attr = primary_attr
        self.attack_type = attack_type
        self.img = img
        self.icon = icon
        self.base_health = base_health
        self.base_health_regen = base_health_regen
        self.base_mana = base_mana
        self.base_mana_regen = base_mana_regen
        self.base_armor = base_armor
        self.base_mr = base_mr
        self.base_attack_min = base_attack_min
        self.base_attack_max = base_attack_max
        self.base_str = base_str
        self.base_agi = base_agi
        self.base_int = base_int
        self.str_gain = str_gain
        self.agi_gain = agi_gain
        self.int_gain = int_gain
        self.attack_range = attack_range
        self.projectile_speed = projectile_speed
        self.attack_rate = attack_rate
        self.move_speed = move_speed
    }
    override init(){}
    
}
