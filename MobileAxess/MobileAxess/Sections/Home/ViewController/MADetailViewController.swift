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
    
    var typeOfCell: CellType {
        guard let itemModel = dataItemModel  else {
            return .textType
        }
        return itemModel.type
    }
    
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
    
    lazy var textView: UITextView = {
        let textview = UITextView()
        textview.textAlignment = .center
        textview.font = UIFont.systemFont(ofSize: 16)
        return textview
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Remove", for: .normal)
        button.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         setUpUI()
        navigationController?.delegate = self
    }
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        guard let dataItem = dataItemModel else {
            return
        }
        
        idLabel.text = dataItem.idLabelText
        creationLabel.text = dataItem.createLabelText
    
        view.addSubview(idLabel)
        view.addSubview(creationLabel)
        
        view.addSubview(button)
        
        setUpConstraintForLabels()
        
        if typeOfCell == .imageType {
            view.addSubview(itemImage)
            loadImageWithPath(urlString: dataItem.imageURL)
            setUpConstraintForImage()
        
        } else {
            view.addSubview(textView)
            textView.text = dataItem.dataLabelText
            setUpConstraintForTextView()
        }
    }
    
    private func setUpConstraintForLabels() {
        
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
        
        button.snp.makeConstraints { (maker) in
            maker.height.equalTo(100)
            maker.bottom.equalToSuperview().offset(-200)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
        }
      
    }
    
    private func setUpConstraintForImage() {
        itemImage.snp.makeConstraints { (maker) in
            maker.top.equalTo(idLabel.snp_bottomMargin).offset(50)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(300)
        }
    }
    
    private func setUpConstraintForTextView() {
        textView.snp.makeConstraints { (maker) in
            maker.top.equalTo(idLabel.snp_bottomMargin).offset(50)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(20)
        }
    }
    
    private func loadImageWithPath(urlString: URL?) {
        
        SDWebImageManager.shared.loadImage(with: urlString, options: .scaleDownLargeImages, progress: nil) { [weak self] (image, _, error, _, _, _) in
            DispatchQueue.main.async {
                self?.itemImage.image = image
            }
        }
    }
    
    @objc func removeItem() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MADetailViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let controller = viewController as? MAHomeViewController else {
            return
        }
        controller.passedObject = dataItemModel
        controller.presentAlert()
    }
    
}
