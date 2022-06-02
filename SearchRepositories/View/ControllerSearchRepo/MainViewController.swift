//
//  MainViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/22/21.
//

import UIKit
import SafariServices
import SVProgressHUD

class MainViewController: UIViewController {
    @IBOutlet weak var txtSearchText: UITextField!
    @IBOutlet weak var viewSeach: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [ItemModel] = []
    private var refreshControl: UIRefreshControl!
    private var canLoadMore: Bool = false
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        hideKeyboardWhenTappedAround()
        handViewModel()
        viewSeach.layer.cornerRadius = 15
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
private extension MainViewController {
    func setupTableView() {
        tableView.register(UINib(nibName: MainTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        txtSearchText.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string:  "")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(){
        viewModel.refresh()
        refreshControl.endRefreshing()
    }
    
    @objc func handleSearchTextField(){
        let text = txtSearchText.text ?? ""
        viewModel.refresh(text: text)
    }
    
    func handViewModel(){
        viewModel.getDataHeros()
        viewModel.items.bind { [weak self] (items) in
            self?.items = items
            self?.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = MainCellModel(item: items[indexPath.row])
        cell.bindViewModel(viewModel)
        cell.actionFavo = {
            if self.viewModel.isFavo(id: self.items[indexPath.row].id) {
                self.viewModel.deleteItem(id: self.items[indexPath.row].id)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                self.viewModel.addFavorite(item: self.items[indexPath.row], vc: self)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        return cell
    }
    
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = SFSafariViewController(url: URL(string: "\(items[indexPath.row].urlRepo)")!)
//        present(vc, animated: true, completion: nil)
        let vc = HeroDetailViewController()
        vc.hero = viewModel.items.value[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .destructive, title: "Favorite") { action, view, completion in
//
//            self.viewModel.addFavorite(item: self.items[indexPath.row], vc: self)
//            completion(true)
//
//        }
//
//        edit.backgroundColor = .green
//        let conf = UISwipeActionsConfiguration(actions: [edit])
//        return conf
//
//    }
}
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleSearchTextField), object: nil)
        SVProgressHUD.show()
        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        SVProgressHUD.show()
        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchText.becomeFirstResponder()
        return true
    }
}
