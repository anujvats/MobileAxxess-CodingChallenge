//
//  Connectivity.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Alamofire

class Connectivity{
    class func isNetworkAvailable() -> Bool {
        guard let netWorkManager = NetworkReachabilityManager() else {
            return false
        }
       return netWorkManager.isReachable
    }
}
