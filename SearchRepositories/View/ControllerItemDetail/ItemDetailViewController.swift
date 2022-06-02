//
//  ItemDetailViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Tuấn Anh Nguyễn on 31/05/2022.
//

import UIKit
import Alamofire
import SDWebImage

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
    @IBAction private func closeTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setUpView() {
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        guard let item = item else {
            return
        }
        
        let imageURL = URL(string: "https://api.opendota.com\(item.img ?? "")")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "logo"))
        itemNameLabel.text = item.dname ?? ""
        loreLabel.text = item.lore ?? ""
        hintLabel.text = ""
        notesLabel.text = item.notes ??  ""
    }
}
