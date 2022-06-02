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
    @IBOutlet weak var nameHero: UILabel!
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
    
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var goodAgai: UILabel!
    @IBOutlet weak var lineUpButotn: UIButton!
    @IBOutlet weak var badAgai: UILabel!
    var hero: ItemModel = ItemModel()
    var viewModel = MainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameHero.text = hero.localized_name
       
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
      
        addFavoriteButton.layer.cornerRadius = 10
        lineUpButotn.layer.cornerRadius = 10
        if !self.viewModel.isFavo(id: hero.id) {
            self.addFavoriteButton.setTitle("Add Favorite", for: .normal)
            self.addFavoriteButton.backgroundColor = .white
            self.addFavoriteButton.setTitleColor(.orange, for: .normal)
        } else {
            self.addFavoriteButton.setTitle("Delete Favorite", for: .normal)
            self.addFavoriteButton.backgroundColor = .orange
            self.addFavoriteButton.setTitleColor(.white, for: .normal)
        }
        
        getDataCouter()
    }
    
    func getDataCouter() {
        do {
            let path = Bundle.main.path(forResource: "abc", ofType: "json")!
            let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let respon = JSON(parseJSON: jsonString)
            
            respon.arrayValue.forEach({ item in
                if item["name"].stringValue == hero.localized_name {
                    let bad_against = item["bad_against"].arrayValue
                    let good_against = item["good_against"].arrayValue
                    var textbad_against: [String] = []
                    var textgood_against: [String] = []
                    bad_against.forEach { text in
                        textbad_against.append(text.stringValue)
                    }
                    good_against.forEach { text in
                        textgood_against.append(text.stringValue)
                    }
                    
                    badAgai.text = textbad_against.joined(separator: ", ")
                    goodAgai.text = textgood_against.joined(separator: ", ")
                }
            })
        } catch _ {
            
        }
        
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        if self.viewModel.isFavo(id: hero.id) {
            self.viewModel.deleteItem(id: hero.id)
            self.addFavoriteButton.setTitle("Add Favorite", for: .normal)
            self.addFavoriteButton.backgroundColor = .white
            self.addFavoriteButton.setTitleColor(.orange, for: .normal)
        } else {
            viewModel.addFavorite(item: hero, vc: self)
            self.addFavoriteButton.setTitle("Delete Favorite", for: .normal)
            self.addFavoriteButton.backgroundColor = .orange
            self.addFavoriteButton.setTitleColor(.white, for: .normal)
        }
    }
    @IBAction func lineUp(_ sender: Any) {
        let vc = HeroLoreViewController()
        vc.hero = hero
        self.present(vc, animated: true, completion: nil)
    }
}
