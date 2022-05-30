//
//  FavoriteViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/4/21.
//

import UIKit
import RealmSwift
import SafariServices
import DropDown

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarFavo: UITextField!
    @IBOutlet weak var menuBarButton: UIButton!
    
    var viewModel = FavoriteViewModel()
    var items: [Favorite] = []
    var searchItem: [Favorite] = []
    let rightBarDropDown = DropDown()
    
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
    
    func addData(){
        viewModel.addItem(itemsFavo: items)
        viewModel.items.bind { [weak self] (favorite) in
            self?.items = favorite
            self?.tableView.reloadData()
        }
    }
    
    func getDataAZ(){
        items.removeAll()
        viewModel.sortItemAZ()
        viewModel.items.bind {[weak self] (favorite) in
            self?.items = favorite
            self?.tableView.reloadData()
        }
    }
    
    func getDataZA(){
        items.removeAll()
        viewModel.sortItemZA()
        viewModel.items.bind {[weak self] (favorite) in
            self?.items = favorite
            self?.tableView.reloadData()
        }
    }
    
    
    @objc func getSearchData() {
        viewModel.searchItem(text: searchBarFavo.text ?? "")
        print(searchBarFavo.text)
        viewModel.searchItems.bind { [weak self] (favorite) in
            self?.searchItem = favorite
            self?.tableView.reloadData()
        }
    }
    
    func setupView(){
        tableView.register(UINib(nibName: FavoriteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBarFavo.delegate = self
        setUpMenu()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteAllItem))
    }
    
    func setUpMenu() {
        rightBarDropDown.anchorView = menuBarButton
        rightBarDropDown.dataSource = ["Name (A -> Z)", "Name (Z -> A)"]
        rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }
    }
    @IBAction func menuBarButtonAction(_ sender: Any) {
        rightBarDropDown.selectionAction = { (index: Int, item: String) in
            switch index {
            case 0:
                self.getDataAZ()
                
            case 1:
                self.getDataZA()
            default:
                break
            }
        }
        
        rightBarDropDown.width = 140
        rightBarDropDown.bottomOffset = CGPoint(x: 0, y:( rightBarDropDown.anchorView?.plainView.bounds.height )!)
        rightBarDropDown.show()
    }
    
    @objc func deleteAllItem() {
        let alert = UIAlertController(title: "Wairning", message: "Are you sure ??", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { (alert) in
            self.viewModel.deleteAll()
            self.reloadTableView()
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarFavo.text!.isEmpty {
            return items.count
        }else {
            return searchItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier,for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        if searchBarFavo.text!.isEmpty {
            let viewModel = FavoriteCellModel(item: items[indexPath.row])
            cell.bindViewModel(viewModel)
            return cell
        }else {
            let viewModel = FavoriteCellModel(item: searchItem[indexPath.row])
            cell.bindViewModel(viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = SFSafariViewController(url: URL(string: items[indexPath.row].urlRepo)!)
//        present(vc, animated: true, completion: nil)
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            
            self.viewModel.deleteItem(item: self.items[indexPath.row], index: indexPath.row)
            self.reloadTableView()
            completion(true)
        }
        delete.backgroundColor = .red
        let conf = UISwipeActionsConfiguration(actions: [delete])
        return conf
        
    }
    
}

extension FavoriteViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        addData()
    }
}

extension FavoriteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchData), object: nil)
        perform(#selector(getSearchData),with: textField, afterDelay: 0.1)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        perform(#selector(getSearchData),with: textField, afterDelay: 0.1)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarFavo.becomeFirstResponder()
        return true
    }
}
