//
//  MainViewModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation
import Alamofire
import RealmSwift

final class MainViewModel {
    
    private var isLoading = false
    private var numberOfpage = BaseConstant.pageSize
    private var curPage = BaseConstant.startPage
    private var isRefresh = false
    private var searchText = ""
    
    var items: Box<[ItemModel]> = Box([])
    var hiddenViewSearchResult = Box(false)
    var totalRepos = Box(" ")
    var canLoadMore = Box(true)
    var databaseRealm = DataManagerRealm()
    
    var count = 0
    
    init() { }
    
    func refresh(text: String = "") {
        isRefresh = true
        curPage = BaseConstant.startPage
        searchData(text: text)
    }
    
    func searchData(text: String = "") {
        guard !isLoading else {
            return
        }
        isLoading = true
        searchText = text
        let param: Parameters = [
            ParameterKeys.Search.q.rawValue: text,
            ParameterKeys.Search.perPage.rawValue: numberOfpage,
            ParameterKeys.Search.page.rawValue: "\(curPage)"
        ]
        print(param)
        APIClient.sharedInstance.searchRepository(params: param) { [weak self] (response, error) in
            guard let self = self else{ return }
            self.handleResponseObject(response: response!)
        }
    }
    
    func addFavorite( item: ItemModel,vc: UIViewController) {
        let favorite = Favorite(id: item.id,
                                fullName: item.fullName,
                                descrip: item.description,
                                stargezersCount: item.stargezersCount,
                                language: item.language,
                                forksCount: item.forksCount,
                                nameAuthor: item.nameAuthor,
                                urlRepo: item.urlRepo)
  
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
          guard let repositories = try? AppUtil.convertJsonString(response, toType: SearchModel.self) else{
            items.value = []
            hiddenViewSearchResult.value = true
            curPage = BaseConstant.startPage
            return
            }
            
            hiddenViewSearchResult.value = searchText.isEmpty
            totalRepos.value = String(format: kRepositoryResult, "\(repositories.totalCount)")
            
            if isRefresh {
                items.value.removeAll()
                isRefresh = false
            }
            
            curPage += 1
            for item in repositories.items where !items.value.contains(item) {
                items.value.append(item)
            }
            canLoadMore.value = !repositories.items.isEmpty
        }
    }
}
