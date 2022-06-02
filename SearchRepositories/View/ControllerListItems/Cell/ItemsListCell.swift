//
//  ItemsListCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Tuấn Anh Nguyễn on 31/05/2022.
//

import UIKit
import Alamofire
import SDWebImage

class ItemsListCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var goldLabel: UILabel!
    
    private var item: ItemDotaModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpData(item: ItemDotaModel) {
        self.item = item
        
        let imageURL = URL(string: "https://api.opendota.com\(item.img ?? "")")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "logo"))
        
        nameLabel.text = item.dname
        goldLabel.text = "\(item.cost ?? 0)"
    }
    
    private func setUpView() {
        containerView.layer.cornerRadius = 8
       // containerView.layer.borderColor = UIColor.blue.cgColor
    }
}
