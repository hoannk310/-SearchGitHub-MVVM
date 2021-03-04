//
//  MainViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/22/21.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    @IBOutlet weak var txtSearchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCount: UILabel!
    
    private var items: [ItemModel] = []
    private var refreshControl: UIRefreshControl!
    private var canLoadMore: Bool = false
    private let viewModel = MainViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        hideKeyboardWhenTappedAround()
        handViewModel()
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
        viewModel.items.bind { [weak self] (items) in
            self?.items = items
            self?.tableView.reloadData()
        }
        
        viewModel.hiddenViewSearchResult.bind { (isHidden) in
            self.lblCount.isHidden = isHidden
           
        }
        
        viewModel.totalRepos.bind { (totalRepos) in
            self.lblCount.text = "   " + totalRepos
        }
        viewModel.canLoadMore.bind { loadMore in
            print(loadMore)
            self.canLoadMore = loadMore
           
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
        return cell
    }
    
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0, canLoadMore {
            viewModel.searchData(text: txtSearchText.text ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: "\(items[indexPath.row].urlRepo)")!)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .destructive, title: "Favorite") { action, view, completion in
       
            self.viewModel.addFavorite(item: self.items[indexPath.row])
            completion(true)
           
        }
        
        edit.backgroundColor = .green
        let conf = UISwipeActionsConfiguration(actions: [edit])
        return conf
        
    }
    
  
}
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleSearchTextField), object: nil)

        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchText.becomeFirstResponder()
        return true
    }
}
