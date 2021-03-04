//
//  MainTableViewCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import UIKit

class MainTableViewCell: UITableViewCell,Identifiable {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var LblSubDescription: UILabel!
    
    private var viewModel: MainCellModel? {
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
    
    func bindViewModel(_ viewModel: MainCellModel) {
        self.viewModel = viewModel
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        lblName.text = viewModel.fullName
        lblDescription.text = viewModel.description
        LblSubDescription.text = viewModel.subDescription
    }
    
}
