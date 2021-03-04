
import Foundation
import Alamofire
import UIKit

final class SearchViewModel {
    private var isLoading = false
    private var numberOfpage = BaseConstant.pageSize
    private var curPage = BaseConstant.startPage
    private var isRefresh = false
    private var searchText = ""
    
    var items: Box<[UserModel]> = Box([])
    var hiddenViewSearchResult = Box(false)
    var totalUsers = Box(" ")
    var canloadMore = Box(true)
    init() {}
    
    func refresh(text: String = "") {
        isRefresh = true
        curPage = BaseConstant.startPage
        searchUser(text: text)
    }
    
    func searchUser(text: String = "") {
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
        APIClient.sharedInstance.searchUser(params: param) {[weak self] (response, error) in
            guard let self = self else {return}
            self.handleUserObject(response: response!)
        }
    }
    
}

private extension SearchViewModel {
    func handleUserObject(response: ResponseObject?) {
        isLoading = false
        do {
            guard let users = try? AppUtil.convertJsonString(response, toType: SearchUser.self) else {
                items.value = []
                hiddenViewSearchResult.value = true
                curPage = BaseConstant.startPage
                return
            }
            
            hiddenViewSearchResult.value = searchText.isEmpty
            totalUsers.value = String(format: kUserResult, "\(users.totalCount)")
        
            if isRefresh {
                items.value.removeAll()
                isRefresh = false
            }
            
            curPage += 1
            for item in users.items where !items.value.contains(item) {
                items.value.append(item)
            }
            canloadMore.value = !users.items.isEmpty
        }
    }

  
}

