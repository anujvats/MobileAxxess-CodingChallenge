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
    func showError(error: MAErrorStatus)
}

class MAHomeViewModel {
    
    var cellItemModels: [MAHomeCellViewModel] = []
    weak var delegate: MAHomeViewModelDelegate?
        
    
    init(delegate: MAHomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadTableView() {
        
        if Connectivity.isNetworkAvailable() {
            getDataFromRemote()
            return
        }
        
        getDataFromLocalStorage()
    }
    
    
  private func getDataFromRemote() {
        BaseAPIPerformer.sharedObject.fetchDataFromAPI { [weak self] (repsonseData, error) in
             if let error = error {
                self?.handleAPIError(error: error)
            }
            if let response = repsonseData {
                self?.handleAPIResponse(itemModels: response)
            }
        }
    }
    
   private func getDataFromLocalStorage() {
        LocalStorageDataSource.shared.fetchItemsLocalDataSource { [weak self] (itemModels) in
            self?.getTheCellViewModel(itemModels: itemModels)
            DispatchQueue.main.async {
                self?.delegate?.reloadTableView()
            }
        }
    }

   private func handleAPIResponse(itemModels: [RealmItemModel]) {
       getTheCellViewModel(itemModels: itemModels)
        LocalStorageDataSource.shared.insertItemsLocalDataSource(itemModels) { [weak self] (error) in
            if let error = error {
                self?.handleAPIError(error: error)
            }
            DispatchQueue.main.async {
                self?.delegate?.reloadTableView()
            }
        }
    }
    
   private func getTheCellViewModel(itemModels: [RealmItemModel]) {
        itemModels.forEach { (itemModel) in
            let cellModel = MAHomeCellViewModel(itemModel: itemModel)
            cellItemModels.append(cellModel)
        }
    }
    
   private func handleAPIError(error: MAErrorStatus) {
        DispatchQueue.main.async {
            self.delegate?.showError(error: error)
        }
    }

}
