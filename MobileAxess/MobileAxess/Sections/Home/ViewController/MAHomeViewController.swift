//
//  MAHomeViewController.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit
import MBProgressHUD

final class MAHomeViewController: UITableViewController {
    
  lazy private var viewModel: MAHomeViewModel = {
        return MAHomeViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerTableView()
        showSpinner()
        viewModel.loadTableView()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
    
    private func registerTableView() {
        tableView.register(MAHomeTableViewCell.self, forCellReuseIdentifier: MAHomeTableViewCell.cellIdentifier)
    }
    
    private func showSpinner() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    private func hideSpinner() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}

// MARK: - Table view data source
extension MAHomeViewController {

}

// MARK: - Table view delegate
extension MAHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellItemModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MAHomeTableViewCell.cellIdentifier, for: indexPath) as? MAHomeTableViewCell else {
            fatalError()
        }
        
        let cellItemModel = viewModel.cellItemModels[indexPath.row]
        
        cell.configureWith(cellItemModel)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemAtIndex = viewModel.cellItemModels[indexPath.row]
        let viewController = MADetailViewController()
        viewController.dataItemModel = itemAtIndex
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MAHomeViewController: MAHomeViewModelDelegate {
    
    func showError(error: MAErrorStatus) {
        
        let alertController = UIAlertController(title: error.domain,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true)
        
    }
    
    
    func reloadTableView() {
        hideSpinner()
        self.tableView.reloadData()
    }
    
}
