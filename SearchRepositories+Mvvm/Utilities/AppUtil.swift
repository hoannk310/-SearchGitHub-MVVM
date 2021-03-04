//
//  AppUtil.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import UIKit

final class AppUtil: NSObject {
    
    class var appDelegate: AppDelegate? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate
    }
    
    class func convertJsonString<T>(_ response: ResponseObject?, toType: T.Type) throws -> T? where T: Decodable {
        guard let jsonData  = response?.jsonString?.data(using: .utf8) else {
           return nil
        }
        let decoder = JSONDecoder()
        do {
          let orderDetailResponse = try decoder.decode(toType, from: jsonData)
            return orderDetailResponse
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
  
}
