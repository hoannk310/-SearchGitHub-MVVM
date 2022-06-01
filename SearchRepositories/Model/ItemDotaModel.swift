// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itemModel = try? newJSONDecoder().decode(ItemModel.self, from: jsonData)

import Foundation

//"blink": {
//    "hint": [
//      "Active: Blink Teleport to a target point up to 1200 units away. Blink Dagger cannot be used for 3 seconds after taking damage from an enemy hero or Roshan."
//    ],
//    "id": 1,
//    "img": "/apps/dota2/images/items/blink_lg.png?t=1593393829403",
//    "dname": "Blink Dagger",
//    "qual": "component",
//    "cost": 2250,
//    "notes": "Self-casting will cause you to teleport in the direction of your team's fountain.\nIf you used Blink to teleport to a distance over the maximum range, you'll be teleported 4/5 of the maximum range instead.",
//    "attrib": [],
//    "mc": false,
//    "cd": 15,
//    "lore": "The fabled dagger used by the fastest assassin ever to walk the lands.",
//    "components": null,
//    "created": false,
//    "charges": false
//  },

struct ItemDotaListModel {
    
    var itemsDota: [ItemDotaModel] = []
}

struct ItemDotaModel: Codable {
    
    let hint: [String]?
    let id: Int?
    let img, dname, qual: String?
    let cost: Int?
    let notes: String?
    let attrib: [ItemAttributesModel]?
    let lore: String?
}

struct ItemAttributesModel: Codable {
    
    let key: String?
    let header: String?
    let valude: String?
    let footer: String?
}
