//
//  MAHomeCellViewModelTest.swift
//  MobileAxessTests
//
//  Created by Anuj Vats on 28/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

@testable import MobileAxess

import Quick
import Nimble

class MAHomeCellViewModelTest: QuickSpec {
    
    override func spec() {
        context("MAHomeCellViewModel Test") {
            describe("it should pass") {
                it("if model is initialized with text type should result in text type") {
                    let itemModel = ItemModel(id: "10", type: "text", date: "20/10/19", data: "this is my test string")
                    let realmModel = RealmItemModel(model: itemModel)
                    let cellItemModel = MAHomeCellViewModel(itemModel: realmModel!)
                    expect(cellItemModel.type).to(equal(CellType.textType))
                }
            }
            
            describe("it should pass") {
                it("if model is initialized with nil type result in text type") {
                    let itemModel = ItemModel(id: "10", type: nil, date: "20/10/19", data: "this is my test string")
                    let realmModel = RealmItemModel(model: itemModel)
                    let cellItemModel = MAHomeCellViewModel(itemModel: realmModel!)
                     expect(cellItemModel.type).to(equal(CellType.textType))
                }
             }
            
            describe("it should pass") {
                it("if we receive expected text string from Model") {
                    let itemModel = ItemModel(id: "10", type: nil, date: "20/10/19", data: "this is my test string")
                let realmModel = RealmItemModel(model: itemModel)
                let cellItemModel = MAHomeCellViewModel(itemModel: realmModel!)
                 expect(cellItemModel.createLabelText).to(equal("createdOn: 20/10/19"))
                }
        }
    }
  }
}
