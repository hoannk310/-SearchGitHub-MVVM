//
//  HeroLoreViewController.swift
//  SearchRepositories
//
//  Created by Hoan on 02/06/2022.
//

import UIKit
import SwiftyJSON

class HeroLoreViewController: UIViewController {
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    var hero: ItemModel = ItemModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTop.layer.cornerRadius = 2
        nameLB.text = hero.localized_name
        do {
            let path = Bundle.main.path(forResource: "hero_lore", ofType: "json")!
            let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let json = JSON(parseJSON: jsonString)
            let name = hero.localized_name.lowercased()
            let nameReplace = name.replacingOccurrences(of: "-", with: "")
            let nameJson = nameReplace.replacingOccurrences(of: " ", with: "_")
            if hero.localized_name == "Shadow Fiend" {
                self.textview.text = json["shadow_demon"].stringValue
            } else {
                self.textview.text = json[nameJson].stringValue
            }
        } catch _ {
            
        }
        let heightTV = textview.contentSize.height
        scrollview.contentSize = CGSize(width: view.frame.width, height: heightTV + 472)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
