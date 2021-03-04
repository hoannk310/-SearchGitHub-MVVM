//
//  SearchTableViewCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import UIKit
import AlamofireImage
import Alamofire

class SearchTableViewCell: UITableViewCell, Identifiable {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblUrl: UILabel!
    
    private var viewModel: SearchCellModel? {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    func bindViewModel(_ viewModel: SearchCellModel) {
        self.viewModel = viewModel
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        lblName.text = viewModel.name
        imageUser.loadImage(url: viewModel.image)
        lblUrl.text =  viewModel.url
    }
            
}

extension UIImageView {
    func loadImage(url: String) {
        AF.request(url,method: .get).responseImage { (response) in
            guard let data = response.data else {return}
            self.image = UIImage(data: data)
        }
    }
}
