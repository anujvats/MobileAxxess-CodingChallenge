//
//  MAHomeCellViewModel.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation

enum CellType {
    case imageType
    case textType
}

class MAHomeCellViewModel {
    
    var idLabelText: String {
        return "id: " + (cellItemModel.id ?? "")
    }
    
    var typeLabelText: String? {
        return "type: " + (cellItemModel.type ?? "")
    }
    
    var createLabelText: String? {
        return "createdOn: " + (cellItemModel.date ?? "")
    }
    
    var dataLabelText: String? {
        return "data: " + (cellItemModel.data ?? "")
    }
    
    var type: CellType {
        guard let type = cellItemModel.type else {
            return .textType
        }
        
        switch type.lowercased() {
        case "text":
            return .textType
        case "image":
            return .imageType
        default:
            return .textType
        }
    }
    
    private let cellItemModel: ItemModel
    
    
    init(itemModel: ItemModel) {
        cellItemModel = itemModel
    }
    
}
