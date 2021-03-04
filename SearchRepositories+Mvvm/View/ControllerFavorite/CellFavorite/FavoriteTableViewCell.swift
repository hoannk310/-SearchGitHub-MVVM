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
    }
}
