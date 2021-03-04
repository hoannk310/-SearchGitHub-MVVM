//
//  DetailUserTableViewCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/3/21.
//

import UIKit

class DetailUserTableViewCell: UITableViewCell, Identifiable{
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var LblSubDescription: UILabel!
    
    
    private var viewModel: DetailCellModel? {
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
    
    func bindViewModel(_ viewModel: DetailCellModel) {
        self.viewModel = viewModel
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        lblFullName.text = viewModel.fullName
        lblDescription.text = viewModel.description
        LblSubDescription.text = viewModel.subDescription
    }
    
}
