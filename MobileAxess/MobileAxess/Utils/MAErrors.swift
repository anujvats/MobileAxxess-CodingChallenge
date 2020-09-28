//
//  MAErrors.swift
//  MobileAxess
//
//  Created by Anuj Vats on 28/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation

public let MAErrorDomain: String = "com.mobileaxxess"

enum MAError: Error, CaseIterable {
    case apiFailure
    case dataBaseFailure
    case nullFailure
    case parsingError
    
    var localizedDescription: String {
        switch self {
        case .apiFailure:
            return "API: Not responding"
        case .dataBaseFailure:
             return "Realm: Operation failure"
        case .nullFailure:
            return "Found null value"
        case .parsingError:
            return "Failed to parse JSON"
        }
    }
    
    var rawValue: Int {
        return MAError.allCases.firstIndex(of: self) ?? 0
    }
}

// Application custom error
class MAErrorStatus: NSError {
    convenience init(error: MAError) {
        self.init(domain: MAErrorDomain, code: error.rawValue, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
    }
}
