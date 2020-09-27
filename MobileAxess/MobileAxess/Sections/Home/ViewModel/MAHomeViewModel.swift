//
//  MAHomeViewModel.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import Foundation

protocol MAHomeViewModelDelegate: class {
    func reloadTableView()
}

class MAHomeViewModel {
    
    var cellItemModels: [MAHomeCellViewModel] = []
    weak var delegate: MAHomeViewModelDelegate?
    
    init(delegate: MAHomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getDataFromRemote() {
        BaseAPIPerformer.sharedObject.fetchDataFromAPI { [weak self] (repsonseData, error) in
             if let error = error {
                print(error.localizedDescription)
                
            }
            if let response = repsonseData {
                self?.handleAPIResponse(itemModels: response)
            }
        }
    }
    
    func handleAPIResponse(itemModels: [ItemModel]) {
        itemModels.forEach { (itemModel) in
            let cellModel = MAHomeCellViewModel(itemModel: itemModel)
            cellItemModels.append(cellModel)
        }
        
        delegate?.reloadTableView()
    }
    
    func handleAPIError(errorMessage: Error) {
        
    }
}
