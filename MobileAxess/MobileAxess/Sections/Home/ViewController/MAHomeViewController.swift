//
//  MAHomeViewController.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

final class MAHomeViewController: UIViewController {
    
  lazy private var viewModel: MAHomeViewModel = {
        return MAHomeViewModel(delegate: self)
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .plain)
    }()
    
    lazy var segmentController: UISegmentedControl = {
        let segmentControllerItems = ["All","TextOnly","ImageOnly"]
        let segmentController = UISegmentedControl(items: segmentControllerItems)
        segmentController.selectedSegmentIndex = 0
        return segmentController
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
        
        let stackView = UIStackView(arrangedSubviews: [self.segmentController,self.tableView])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { (maker) in
            maker.bottom.leading.trailing.equalToSuperview()
            maker.top.equalTo(90)
        }
        
        segmentController.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
        
    }
    
    private func registerTableView() {
        tableView.register(MAHomeTableViewCell.self, forCellReuseIdentifier: MAHomeTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showSpinner() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    private func hideSpinner() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
   @objc private func segmentedControlValueChanged(segment: UISegmentedControl) {
    
        showSpinner()
        
        if segment.selectedSegmentIndex == 0 {
            viewModel.provideAllType()
        } else if segment.selectedSegmentIndex == 1 {
            viewModel.provideOnlyTextType()
        }else {
            viewModel.provideOnlyImageType()
        }
    }
    
}

// MARK: - Table view data source
extension MAHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItemModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MAHomeTableViewCell.cellIdentifier, for: indexPath) as? MAHomeTableViewCell else {
            fatalError()
        }
        
        let cellItemModel = viewModel.filteredItemModels[indexPath.row]
        
        cell.configureWith(cellItemModel)
        
        return cell
    }
}

// MARK: - Table view delegate
extension MAHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
          let itemAtIndex = viewModel.filteredItemModels[indexPath.row]
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
