//
//  SearchUserViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class SearchUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [UserModel] = []
    private var refreshControl: UIRefreshControl!
    private var canLoadMore: Bool = false
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        hideKeyboardWhenTappedAround()
        getData()
    }
}

private extension SearchUserViewController {
    func setUpTableView() {
        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData() {
        SVProgressHUD.show()
        do {
            let path = Bundle.main.path(forResource: "Player", ofType: "json")!
            let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let respon = JSON(parseJSON: jsonString)
            
            respon.arrayValue.forEach({ item in
                let user = UserModel(name: item["name"].stringValue,
                                     avatar: item["avatar"].stringValue,
                                     team_name: item["team_name"].stringValue,
                                     steamid: item["steamid"].stringValue,
                                     personaname: item["personaname"].stringValue,
                                     team_tag: item["team_tag"].stringValue,
                                     loccountrycode: item["loccountrycode"].stringValue,
                                     avafull: item["avatarfull"].stringValue)
                items.append(user)
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            })
        } catch _ {
            
        }
    }
    
    private func handleUserObject(response: ResponseObject?) {
        do {
            guard let data = response?.data else { return }
            guard let respon = try? JSON(data: data) else {
                return
            }
            
            respon.arrayValue.forEach({ item in
                let user = UserModel(name: item["name"].stringValue,
                                     avatar: item["avatar"].stringValue,
                                     team_name: item["team_name"].stringValue)
                items.append(user)
                self.tableView.reloadData()
            })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = DetailUserViewController()
        //        vc.title = items[indexPath.row].name
        //        vc.user = items[indexPath.row]
        //        vc.hidesBottomBarWhenPushed = true
        //        navigationController?.pushViewController(vc, animated: true)
        let vc = ProPlayerDetailViewController()
        vc.user = items[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
