//
//  BaseAPIPerformer.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPIPerformer {
   
   static let sharedObject = BaseAPIPerformer()
    
    func fetchDataFromAPI(completionHadler: @escaping ([ItemModel]?,Error?) -> ()){
        AF.request(ServiceEndPointURL.mobileAxxessAPI).responseData { (responseData) in
            
            if let error = responseData.error {
                completionHadler(nil, error)
                return
            }
            
            guard let data = responseData.data else { return }
            
            do {
                
                let decodable = try JSONDecoder().decode([ItemModel].self, from: data)
                completionHadler(decodable, nil)
            
            } catch let decodeError {
                completionHadler(nil, decodeError)
            }
        }
    }
    
}
