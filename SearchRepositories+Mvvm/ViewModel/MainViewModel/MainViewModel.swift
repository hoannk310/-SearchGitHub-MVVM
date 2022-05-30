//
//  MainViewModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation
import Alamofire
import RealmSwift
import SVProgressHUD
final class MainViewModel {
    
    private var isLoading = false
    private var numberOfpage = BaseConstant.pageSize
    private var curPage = BaseConstant.startPage
    private var isRefresh = false
    private var searchText = ""
    
    var items: Box<[ItemModel]> = Box([])
    var totalRepos = Box(" ")
    var canLoadMore = Box(true)
    var databaseRealm = DataManagerRealm()
    var arrayFull: [ItemModel] = []
    var count = 0
    
    init() { }
    
    func refresh(text: String = "") {
        guard !isLoading else {
            return
        }
        
        curPage = BaseConstant.startPage
       
        items.value.removeAll()
        if text.isEmpty {
            items.value.append(contentsOf: arrayFull)
        }
        for item in arrayFull where item.fullName.lowercased().contains(text.lowercased()) {
            items.value.append(item)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    func getDataHeros() {
        guard !isLoading else {
            return
        }
        isLoading = true
        APIClient.sharedInstance.searchRepository() { [weak self] (response, error) in
            guard let self = self else{ return }
            self.handleResponseObject(response: response!)
        }
    }
    
    func addFavorite( item: ItemModel,vc: UIViewController) {
        let favorite = Favorite(id: item.id,
                                fullName: item.fullName,
                                descrip: item.description,
                                role: item.role,
                                legs: item.legs,
                                primary_attr: item.primary_attr,
                                name: item.name)
        let items = databaseRealm.getAllItem()
        
        for item in items {
            if favorite.id == item.id {
                count += 1
            }
        }
        if (count == 0)  {
            AppUtil.createNotification(title: "Success", body: "Successfully added to favorites", time: 0.1, identifier: "\(item.id)")
            databaseRealm.addData(object: favorite)
           
            print("thêm")
        }else{
            count = 0
            AppUtil.showAlert(text: "Already exists in favorites", vc: vc)
        }
        
    }
    
  
    
}
private extension MainViewModel {
    func handleResponseObject(response: ResponseObject?) {
        isLoading = false
        do {
          guard let repositories = try? AppUtil.convertJsonString(response, toType: [ItemModel].self) else{
            items.value = []
            curPage = BaseConstant.startPage
            return
            }
            
         //   totalRepos.value = String(format: kRepositoryResult, "\(repositories.totalCount)")
            
            curPage += 1
            for item in repositories where !items.value.contains(item) {
                items.value.append(item)
            }
            arrayFull = items.value
            canLoadMore.value = !repositories.isEmpty
        }
    }
}
