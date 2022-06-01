//
//  FavoriteTableViewCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell, Identifiable {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescrip: UILabel!
    @IBOutlet weak var LblSubDescription: UILabel!
    @IBOutlet weak var icn_image: UIImageView!
    
    private var viewModel: FavoriteCellModel? {
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

        // Configure the view for the selected state
    }
    
    func bindViewModel(_ viewModel: FavoriteCellModel) {
        self.viewModel = viewModel
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        lblName.text = viewModel.fullName
        lblDescrip.text = viewModel.description
        LblSubDescription.text = viewModel.subDescription
        switch viewModel.primary_attr {
        case "agi":
            LblSubDescription.textColor = UIColor.green
        case "str":
            LblSubDescription.textColor = UIColor.red
        case "int":
            LblSubDescription.textColor = UIColor.systemBlue
        default:
            break
        }
        
        icn_image.downloadImage(url: viewModel.iconImg)
    }
}
