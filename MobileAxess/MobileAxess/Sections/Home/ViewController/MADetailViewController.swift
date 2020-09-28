//
//  MADetailViewController.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MADetailViewController: UIViewController {
    
    var dataItemModel: MAHomeCellViewModel?
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()
    
    lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var creationLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .cyan
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         setUpUI()
    }
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        guard let dataItem = dataItemModel else {
            return
        }
        
        idLabel.text = dataItem.idLabelText
        creationLabel.text = dataItem.createLabelText
        
        switch dataItem.type {
        case .imageType:
            loadImageWithPath(urlString: dataItem.imageURL)
        default:
            break
        }
        
        view.addSubview(idLabel)
        view.addSubview(creationLabel)
        view.addSubview(itemImage)
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        idLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(104)
            maker.width.equalTo(creationLabel.snp.width)
            maker.height.equalTo(50)
        }
        
        creationLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(idLabel.snp.trailing).offset(20)
            maker.top.equalToSuperview().offset(104)
            maker.trailing.equalToSuperview().offset(-10)
            maker.width.equalTo(idLabel.snp.width)
            maker.height.equalTo(50)
        }
        
        itemImage.snp.makeConstraints { (maker) in
            maker.top.equalTo(idLabel.snp_bottomMargin).offset(50)

            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(20)
            maker.height.equalTo(300)
        }
    }
    
    private func loadImageWithPath(urlString: URL?) {
        
        SDWebImageManager.shared.loadImage(with: urlString, options: .scaleDownLargeImages, progress: nil) { [weak self] (image, _, error, _, _, _) in
            DispatchQueue.main.async {
                self?.itemImage.image = image
            }
        }
    }
}
