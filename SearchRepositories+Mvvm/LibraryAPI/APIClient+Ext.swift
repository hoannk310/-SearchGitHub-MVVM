//
//  APIClient+Ext.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Alamofire

extension APIClient {
    func searchRepository(completed: @escaping CompletionBlock){
        getRequestPath(path: "heroStats", callback: completed)
    }
    
    func searchUser(params: Parameters, completed: @escaping CompletionBlock) {
        getRequestPath(path: "users", param: params, callback: completed)
    }
    
    func detailUserRepo(user: String, parmas: Parameters, completed: @escaping CompletionBlock){
        getRequestPathUserClick(path: "\(user)/repos", param: parmas, callback: completed)
    }
}
