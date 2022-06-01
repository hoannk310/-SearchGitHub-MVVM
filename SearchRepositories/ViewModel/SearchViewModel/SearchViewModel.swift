
import Foundation
import Alamofire
import UIKit
import SwiftyJSON
import SVProgressHUD

final class SearchViewModel {
    private var isLoading = false
    private var numberOfpage = BaseConstant.pageSize
    private var curPage = BaseConstant.startPage
    private var isRefresh = false
    private var searchText = ""
    
    var items: Box<[UserModel]> = Box([])
    var arrayFull: [UserModel] = []
    var hiddenViewSearchResult = Box(false)
    var totalUsers = Box(" ")
    var canloadMore = Box(true)
    init() {}
    
    func refresh(text: String = "") {
        guard !isLoading else {
            return
        }
               
        items.value.removeAll()
        if text.isEmpty {
            items.value.append(contentsOf: arrayFull)
        }
        for item in arrayFull where item.name.lowercased().contains(text.lowercased()) {
            items.value.append(item)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SVProgressHUD.dismiss()
        }
    }
    func getDataUser() {
        guard !isLoading else {
            return
        }
        isLoading = true
      
//        APIClient.sharedInstance.searchUser() {[weak self] (response, error) in
//            guard let self = self else {return}
//            self.handleUserObject(response: response!)
//        }
        do {
            let path = Bundle.main.path(forResource: "Player", ofType: "json")!
            let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let respon = JSON(parseJSON: jsonString)
          
            respon.arrayValue.forEach({ item in
                let user = UserModel(name: item["name"].stringValue,
                                     avatar: item["avatar"].stringValue,
                                     team_name: item["team_name"].stringValue)
                items.value.append(user)
            })
            arrayFull = items.value
        } catch _ {
            
        }
    }
    
}

private extension SearchViewModel {
    func handleUserObject(response: ResponseObject?) {
        isLoading = false
        do {
            guard let data = response?.data else { return }
            guard let respon = try? JSON(data: data) else {
                items.value = []
                hiddenViewSearchResult.value = true
                return
            }
            
            respon.arrayValue.forEach({ item in
                let user = UserModel(name: item["name"].stringValue,
                                     avatar: item["avatar"].stringValue,
                                     team_name: item["team_name"].stringValue)
                items.value.append(user)
            })
            arrayFull = items.value
        }
    }
}

