//
//  HeroDetailViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Hoan on 30/05/2022.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class HeroDetailViewController: UIViewController {
    @IBOutlet weak var imageHR: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var baseHealth: UILabel!
    @IBOutlet weak var baseHealthRegen: UILabel!
    @IBOutlet weak var baseMana: UILabel!
    @IBOutlet weak var baseManaRegen: UILabel!
    @IBOutlet weak var baseArmor: UILabel!
    @IBOutlet weak var base_agi: UILabel!
    
    @IBOutlet weak var base_str: UILabel!
    @IBOutlet weak var moveSpeed: UILabel!
    
    @IBOutlet weak var base_int: UILabel!
    
    var hero: ItemModel = ItemModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let heightTV = textView.contentSize.height
        scrollview.contentSize = CGSize(width: view.frame.width, height: heightTV + 472)
        let urlImage = "https://api.opendota.com" + hero.img
        imageHR.downloadImage(url: urlImage)
        baseHealth.text = "\(hero.base_health)"
        baseHealthRegen.text = "\(hero.base_health_regen)"
        baseMana.text = "\(hero.base_mana)"
        baseManaRegen.text = "\(hero.base_mana_regen)"
        baseArmor.text = "\(hero.base_armor)"
        base_agi.text = "\(hero.base_agi)"
        base_int.text = "\(hero.base_int)"
        base_str.text = "\(hero.base_str)"
        moveSpeed.text = "\(hero.move_speed)"
        do {
            let path = Bundle.main.path(forResource: "hero_lore", ofType: "json")!
            let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let json = JSON(parseJSON: jsonString)
            let name = hero.localized_name.lowercased()
            let nameReplace = name.replacingOccurrences(of: "-", with: "")
            let nameJson = nameReplace.replacingOccurrences(of: " ", with: "_")
            self.textView.text = json[nameJson].stringValue
        } catch _ {
            
        }
    }
}
