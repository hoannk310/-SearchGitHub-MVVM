//
//  ItemDetailViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Tuấn Anh Nguyễn on 31/05/2022.
//

import UIKit
import Alamofire

class ItemDetailViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var loreLabel: UILabel!
    @IBOutlet private weak var hintLabel: UILabel!
    @IBOutlet private weak var notesLabel: UILabel!
    
    var item: ItemDotaModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        guard let item = item else {
            return
        }
        
        let imageURL = URL(string: "https://api.opendota.com\(item.img ?? "")")
        imageView.af.setImage(withURL: imageURL!)
        itemNameLabel.text = item.dname ?? ""
        loreLabel.text = item.lore ?? ""
        hintLabel.text = item.hint?.first ?? ""
        notesLabel.text = item.notes ??  ""
    }
}
