//
//  SearchUserViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import UIKit
import SVProgressHUD

class SearchUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchUserTf: UITextField!
    
    private var items: [UserModel] = []
    private var refreshControl: UIRefreshControl!
    private var canLoadMore: Bool = false
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        handViewModel()
        hideKeyboardWhenTappedAround()
    }
}

private extension SearchUserViewController {
    func setUpTableView() {
        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchUserTf.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        viewModel.refresh()
        refreshControl.endRefreshing()
    }
    
    @objc func handleSearchTextField(){
        let text = searchUserTf.text ?? ""
        viewModel.refresh(text: text)
        
    }
    
    func handViewModel(){
        viewModel.getDataUser()
        viewModel.items.bind { [weak self] (items) in
            self?.items = items
            self?.tableView.reloadData()
        }
        
        viewModel.canloadMore.bind { loadMore in
            self.canLoadMore = loadMore
           
        }
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = SearchCellModel(item: items[indexPath.row])
        cell.bindViewModel(viewModel)
        return cell
    }
  
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10.0, canLoadMore {
//            viewModel.searchUser(text: searchUserTf.text ?? "")
//        }
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailUserViewController()
//        vc.title = items[indexPath.row].name
//        vc.user = items[indexPath.row]
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchUserViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        SVProgressHUD.show()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleSearchTextField), object: nil)
        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
       
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        SVProgressHUD.show()
        perform(#selector(handleSearchTextField),with: textField, afterDelay: 1)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchUserTf.becomeFirstResponder()
        return true
    }
}
