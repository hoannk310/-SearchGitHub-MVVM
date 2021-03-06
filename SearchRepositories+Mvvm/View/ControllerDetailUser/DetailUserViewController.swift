//
//  DetailViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import UIKit
import SafariServices

class DetailUserViewController: UIViewController{

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblWeb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: UserModel?
    private var items: [ItemModel] = []
    private var refreshControl: UIRefreshControl!
    private var canLoadMore: Bool = false
    private let viewModel = DetailUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        hideKeyboardWhenTappedAround()
        handleRequestAPI()
  
    }
 
    @IBAction func test(_ sender: Any) {
        AppUtil.createNotification(title: "hihi", body: "hihi", time: 0.1, identifier: "hihi")
    }
    
    func setUpView(){
        tableView.register(UINib(nibName: DetailUserTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailUserTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        lblName.text = user?.name
        lblWeb.text = user?.url
        imgUser.loadImage(url: user!.image)
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string:  "")
        refreshControl.addTarget(self, action: #selector(refresh), for:.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        viewModel.refresh()
        refreshControl.endRefreshing()
    }
    
    func handViewModel() {
        viewModel.items.bind {[weak self] (items) in
            self?.items = items
            self?.tableView.reloadData()
        }
 
        viewModel.canloadMore.bind { loadMore in
            print(loadMore)
            self.canLoadMore = loadMore
           
        }
    }
    
    func handleRequestAPI() {
        let text = user?.name ?? ""
        viewModel.refresh(text: text)
        handViewModel()
    }
    
}

extension DetailUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailUserTableViewCell.identifier,for: indexPath) as? DetailUserTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = DetailCellModel(item: items[indexPath.row])
        cell.bindViewModel(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: items[indexPath.row].urlRepo)!)
        present(vc, animated: true, completion: nil)
    }
    
}

extension DetailUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0, canLoadMore {
            viewModel.requestDetailUser(text: user!.name)
        }
    }
}

