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
    
    func fetchDataFromAPI(completionHadler: @escaping ([RealmItemModel]?,MAErrorStatus?) -> ()){
        AF.request(ServiceEndPointURL.mobileAxxessAPI).responseData { (responseData) in
            
            if let _ = responseData.error {
                completionHadler(nil, MAErrorStatus(error: .apiFailure))
                return
            }
            
            guard let data = responseData.data else { return }
            
            do {
                
                let decodable = try JSONDecoder().decode([RealmItemModel].self, from: data)
                completionHadler(decodable, nil)
            
            } catch {
                completionHadler(nil, MAErrorStatus(error: .parsingError))
            }
        }
    }
    
}
