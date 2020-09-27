//
//  MAHomeViewController.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit

final class MAHomeViewController: UITableViewController {
    
  lazy private var viewModel: MAHomeViewModel = {
        return MAHomeViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerTableView()
        viewModel.getDataFromRemote()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
    
    private func registerTableView() {
        tableView.register(MAHomeTableViewCell.self, forCellReuseIdentifier: MAHomeTableViewCell.cellIdentifier)
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
    
}

extension MAHomeViewController: MAHomeViewModelDelegate {
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
