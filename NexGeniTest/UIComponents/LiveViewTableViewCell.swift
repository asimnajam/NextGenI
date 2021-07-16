//
//  LiveViewTableViewCell.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import UIKit

final public class LiveViewTableViewCell: UITableViewCell {
    public let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5.0
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.italicSystemFont(ofSize: 12.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, constant: 0.0).isActive = true
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0).isActive = true
        
        
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10.0).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0).isActive = true
    }
    
    public func config(currencyName: String, exRate: String) {
        titleLabel.text = currencyName
        subTitleLabel.text = exRate
    }
}
