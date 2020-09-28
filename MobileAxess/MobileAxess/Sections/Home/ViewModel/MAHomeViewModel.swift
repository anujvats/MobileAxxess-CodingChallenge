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
    
    private var cellItemModels: [MAHomeCellViewModel] = []
    weak var delegate: MAHomeViewModelDelegate?
    
    var filteredItemModels: [MAHomeCellViewModel] = []
    
    init(delegate: MAHomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadTableView() {
        
        // Check for connectivity, if available fetch data from remote
        if Connectivity.isNetworkAvailable() {
            getDataFromRemote()
            return
        }
        
        getDataFromLocalStorage()
    }
    
    func provideOnlyImageType() {
      filteredItemModels = cellItemModels.filter { $0.type == .imageType }
      self.reloadTable()
    }
    
    func provideOnlyTextType() {
        filteredItemModels = cellItemModels.filter { $0.type == .textType }
        self.reloadTable()
    }
    
    func provideAllType() {
        filteredItemModels = cellItemModels
        self.reloadTable()
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
            self?.provideAllType()
        }
    }

   private func handleAPIResponse(itemModels: [RealmItemModel]) {
       getTheCellViewModel(itemModels: itemModels)
       
     //  put the data received from remote in DB everytime for Now
        LocalStorageDataSource.shared.insertItemsLocalDataSource(itemModels) { [weak self] (error) in
            if let error = error {
                self?.handleAPIError(error: error)
            }
            self?.provideAllType()
        }
    }
   
    //Helper Method to convert RealmObject to CellViewModel
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
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }

}
