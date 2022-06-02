//
//  RandomItemViewController.swift
//  SearchRepositories
//
//  Created by Tuấn Anh Nguyễn on 02/06/2022.
//

import UIKit
import Alamofire
import SDWebImage

class RandomItemViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var loreLabel: UILabel!
    @IBOutlet weak var noteTV: UITextView!
    
    var item: ItemDotaModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func closeTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setUpView() {
        let imageURL = URL(string: "https://api.opendota.com\(item?.img ?? "")")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "logo"))
        
        itemNameLabel.text = item?.dname ?? ""
        goldLabel.text = "\(item?.cost ?? 0)"
        loreLabel.text = item?.lore ?? ""
        noteTV.text = item?.notes ?? ""
    }
}
