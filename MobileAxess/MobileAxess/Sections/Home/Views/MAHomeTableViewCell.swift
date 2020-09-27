//
//  MAHomeTableViewCell.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit
import SnapKit

class MAHomeTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "homeTableViewCell"
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.idLabel,self.typeLabel,self.dateLabel,self.dataLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        selectionStyle = .none
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        dataLabel.text = nil
        dateLabel.text = nil
        typeLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        layoutIfNeeded()
    }
    
    func configureWith(_ viewModel: MAHomeCellViewModel) {
        idLabel.text = viewModel.idLabelText
        typeLabel.text = viewModel.typeLabelText
        dateLabel.text = viewModel.createLabelText
        dataLabel.text = viewModel.dataLabelText
    }
    
}
