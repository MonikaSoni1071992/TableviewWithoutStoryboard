//
//  HomeTableViewCell.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    let imgProfileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally and look good in every manner
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let lblDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textColor =  .gray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let countryImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // without this our image will shrink and looks ugly
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(imgProfileImageView)
    containerView.addSubview(lblName)
    containerView.addSubview(lblTitle)
    containerView.addSubview(lblDescription)
    self.contentView.addSubview(containerView)
    // for left side image
    imgProfileImageView.topAnchor.constraint(equalTo: self.lblName.topAnchor, constant: 0).isActive = true
    imgProfileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
    imgProfileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    imgProfileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    // container view as main view
    containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
    containerView.leadingAnchor.constraint(equalTo: self.imgProfileImageView.trailingAnchor, constant: 10).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
    containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 90).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    lblName.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    lblName.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
    lblName.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
    lblName.heightAnchor.constraint(equalToConstant: 20).isActive = true
    lblTitle.topAnchor.constraint(equalTo: self.lblName.bottomAnchor, constant: 5).isActive = true
    lblTitle.leadingAnchor.constraint(equalTo: self.lblName.leadingAnchor).isActive = true
    lblTitle.trailingAnchor.constraint(equalTo: self.lblName.trailingAnchor).isActive = true
    lblTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    lblDescription.translatesAutoresizingMaskIntoConstraints = false
    lblDescription.leadingAnchor.constraint(equalTo: self.lblTitle.leadingAnchor).isActive = true
    lblDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
    lblDescription.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0).isActive = true
    lblDescription.trailingAnchor.constraint(equalTo: self.lblTitle.trailingAnchor).isActive = true
    lblDescription.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 5).isActive = true
    lblDescription.numberOfLines = 0
        }
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    // load data inside tableview cell
    func loadHomeTableData(data: MyHomeDataModel) {
            if let profileImagePath = data.profileImage {
            imgProfileImageView.loadImageUsingCacheWithURLString(profileImagePath, placeHolder: nil) { (_) in }
        }
        if let userName = data.userName {
            lblName.text = " \(userName) "
        }
        if let title = data.title {
            lblTitle.text = " \(title) "
        }
        if let desc = data.descriptions {
            lblDescription.text = " \(desc) "
        }
        }
}
