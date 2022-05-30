//
//  MainTableViewCell.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell,Identifiable {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var LblSubDescription: UILabel!
    @IBOutlet weak var icnHero: UIImageView!
        
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
        
        icnHero.downloadImage(url: viewModel.iconImg)
    }
}

extension UIImageView{
    func downloadImage(url: String){
      //remove space if a url contains.
        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage())
    }
}
