//
//  GetCategory.swift
//  Task1
//
//  Created by Kirolos on 4/3/19.
//  Copyright © 2019 Kirolos. All rights reserved.
//

import Foundation
import Alamofire

class GetCategory {
    
    static let instance = GetCategory()
    static var categories : [category]?
    
    func getCat (Url : String ,completion :@escaping competionHandler){
        Alamofire.request(Url, method: .get ).responseJSON {
            (response) in
            if response.result.error == nil {
                guard let data = response.data  else { return }
                // let json = try? JSONSerialization.data(withJSONObject: data)
                
                guard let ar = try? JSONDecoder().decode([ category].self , from : data)  else {
                    debugPrint(" Can't parse json")
                    return }
                
                debugPrint(ar)
                GetCategory.categories = ar
                
                
                debugPrint(response.result.value as Any)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
