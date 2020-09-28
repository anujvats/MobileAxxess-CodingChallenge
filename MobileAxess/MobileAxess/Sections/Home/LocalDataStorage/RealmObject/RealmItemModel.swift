//
//  RealmItemModel.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation
import RealmSwift


class RealmItemModel: Object, Decodable {
    
    @objc dynamic var id: String = "0"
    @objc dynamic var type: String?
    @objc dynamic var date: String?
    @objc dynamic var data: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case date
        case data
    }
    
    convenience init?(model: ItemModel?) {
        
        guard let itemModel = model else {
            return nil
        }
        
        self.init()
        setValues(itemModel: itemModel)
    }
    
    override class func primaryKey() -> String? {
           return "id"
       }
    
    private func setValues(itemModel: ItemModel) {
        self.id =  itemModel.id ?? "0"
        self.type = itemModel.type
        self.date = itemModel.date
        self.data = itemModel.data
    }
    
    var itemModel: ItemModel {
        let itemModel = ItemModel(id: id,
                                  type: type,
                                  date: date,
                                  data: data)
        return itemModel
    }
}
