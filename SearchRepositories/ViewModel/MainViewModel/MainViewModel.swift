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
import SwiftyJSON

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
        for item in arrayFull where item.localized_name.lowercased().contains(text.lowercased()) {
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
    
    func isFavo(id: Int) -> Bool {
        if databaseRealm.getAllItem().contains(where: {$0.id == id}) {
            return true
        }
        return false
    }
    
    func deleteItem(id: Int) {
        let listFavo = databaseRealm.getAllItem()
        guard let item = listFavo.first(where: {$0.id == id}) else {return}
        databaseRealm.deleteItemFromDB(object: item)
        AppUtil.createNotification(title: "Delete item", body: "Has been delete item", time: 0.1, identifier: "DeleteItem")
    }
    
    func addFavorite( item: ItemModel, vc: UIViewController) {
        let favorite = Favorite(id: item.id, name: item.name, localized_name: item.localized_name, primary_attr: item.primary_attr, attack_type: item.attack_type, role: item.roles, img: item.img, icon: item.icon, base_health: item.base_health, base_health_regen: item.base_health_regen, base_mana: item.base_mana, base_mana_regen: item.base_mana_regen, base_armor: item.base_armor, base_mr: item.base_mr, base_attack_min: item.base_attack_min, base_attack_max: item.base_attack_max, base_str: item.base_str, base_agi: item.base_agi, base_int: item.base_int, str_gain: item.str_gain, agi_gain: item.agi_gain, int_gain: item.int_gain, attack_range: item.attack_range, projectile_speed: item.projectile_speed, attack_rate: item.attack_rate, move_speed: item.move_speed)
        let items = databaseRealm.getAllItem()
        
        for item in items {
            if favorite.id == item.id {
                count += 1
            }
        }
        if (count == 0)  {
            AppUtil.createNotification(title: "Success", body: "Successfully added to favorites", time: 0.1, identifier: "\(item.id)")
            databaseRealm.addData(object: favorite)
           
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
            guard let data = response?.data else {
                return
            }
            guard let responseJson = try? JSON(data: data) else{
              items.value = []
              curPage = BaseConstant.startPage
              return
              }
            responseJson.arrayValue.forEach { respon in
                let itemsJson = ItemModel(id: respon["id"].intValue,
                                          name: respon["name"].stringValue,
                                          localized_name: respon["localized_name"].stringValue,
                                          primary_attr: respon["primary_attr"].stringValue,
                                          attack_type: respon["attack_type"].stringValue,
                                          roles: respon["roles"].arrayValue.map({$0.stringValue}),
                                          img: respon["img"].stringValue,
                                          icon: respon["icon"].stringValue,
                                          base_health: respon["base_health"].intValue,
                                          base_health_regen: respon["base_health_regen"].doubleValue,
                                          base_mana: respon["base_mana"].intValue,
                                          base_mana_regen: respon["base_mana_regen"].intValue,
                                          base_armor: respon["base_armor"].intValue,
                                          base_mr: respon["base_mr"].intValue,
                                          base_attack_min: respon["base_attack_min"].intValue,
                                          base_attack_max: respon["base_attack_max"].intValue,
                                          base_str: respon["base_str"].intValue,
                                          base_agi: respon["base_agi"].intValue,
                                          base_int: respon["base_int"].intValue,
                                          str_gain: respon["str_gain"].doubleValue,
                                          agi_gain: respon["agi_gain"].doubleValue,
                                          int_gain: respon["int_gain"].doubleValue,
                                          attack_range: respon["attack_range"].intValue,
                                          projectile_speed: respon["projectile_speed"].intValue,
                                          attack_rate: respon["attack_rate"].doubleValue,
                                          move_speed: respon["move_speed"].intValue)
                items.value.append(itemsJson)
            }
         
         //   totalRepos.value = String(format: kRepositoryResult, "\(repositories.totalCount)")
            
//            for item in repositories where !items.value.contains(item) {
//                items.value.append(item)
//            }
            arrayFull = items.value
        }
    }
}
