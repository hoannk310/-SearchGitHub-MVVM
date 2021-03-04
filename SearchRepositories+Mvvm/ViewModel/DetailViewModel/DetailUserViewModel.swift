//
//  DetailUserViewModel.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/3/21.
//

import Foundation
import Alamofire
import UIKit
class DetailUserViewModel {
   
    private var isLoading = false
    private var numberOfpage = BaseConstant.pageSizeDetail
    private var curPage = BaseConstant.startPage
    private var isRefresh = false
    private var searchText = ""
    
    var items: Box<[ItemModel]> = Box([])
    var hiddenViewSearchResult = Box(false)
    var totalUsers = Box(" ")
    var canloadMore = Box(true)
    init() {}
    
    func refresh(text: String = "") {
        isRefresh = true
        curPage = BaseConstant.startPage
        requestDetailUser(text: text)
    }
    
    func requestDetailUser(text: String = "") {
        guard !isLoading else {
            return
        }
        isLoading = true
        let param: Parameters = [
            ParameterKeys.Search.perPage.rawValue: numberOfpage,
            ParameterKeys.Search.page.rawValue: "\(curPage)"
            
        ]
        APIClient.sharedInstance.detailUserRepo(user: text, parmas: param) {[weak self] (response, error) in
            guard let self = self else {return}
            self.handleUserObject(response: response!)
        }
    }
    
}
private extension DetailUserViewModel {
    func handleUserObject(response: ResponseObject?) {
        isLoading = false
        do {
            
            guard let repositories = try? AppUtil.convertJsonString(response, toType: [ItemModel].self) else {
                items.value = []
                hiddenViewSearchResult.value = true
                curPage = BaseConstant.startPage
                return
            }
            
            if isRefresh {
                items.value.removeAll()
                isRefresh = false
            }
            
            curPage += 1
            for item in repositories where !items.value.contains(item) {
                items.value.append(item)
            }
            canloadMore.value = !repositories.isEmpty
        }
    }

  
}

