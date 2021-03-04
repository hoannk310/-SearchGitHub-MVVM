//
//  FavoriteViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import UIKit
import RealmSwift
import SafariServices

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = FavoriteViewModel()
    var items: [Favorite] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setupView()
    }
    
    func getData(){
        viewModel.getAllItem()
        viewModel.items.bind { [weak self] (favorite) in
            self?.items = favorite
            self?.tableView.reloadData()
        }
    }
    
    func setupView(){
        tableView.register(UINib(nibName: FavoriteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier,for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = FavoriteCellModel(item: items[indexPath.row])
        cell.bindViewModel(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: items[indexPath.row].urlRepo)!)
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate {
    
}

