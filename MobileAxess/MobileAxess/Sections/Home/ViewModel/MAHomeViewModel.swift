//
//  MAHomeViewModel.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation

class MAHomeViewModel {
    
    
    func getDataFromRemote() {
        BaseAPIPerformer.sharedObject.fetchDataFromAPI { (repsonseData, error) in
             if let error = error {
                print(error.localizedDescription)
                
            }
            if let response = repsonseData {
                print(response)
            }
        }
    }
}
