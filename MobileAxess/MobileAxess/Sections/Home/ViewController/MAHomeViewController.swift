//
//  MAHomeViewController.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit

final class MAHomeViewController: UIViewController {
    
  lazy private var viewModel: MAHomeViewModel = {
        return MAHomeViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.getDataFromRemote()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
    
}
