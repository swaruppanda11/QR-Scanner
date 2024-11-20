//
//  HorizontalButtonCell.swift
//  QR Scanner
//
//  Created by Swarup Panda on 19/11/24.
//

import UIKit

class HorizontalButtonCell: UICollectionViewCell {
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(buttonLabel)
        
        contentView.backgroundColor = UIColor(red: 35/255, green: 45/255, blue: 60/255, alpha: 1.0)
        contentView.layer.cornerRadius = 22.5
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0).cgColor
        contentView.layer.borderWidth = 0.6
        
        NSLayoutConstraint.activate([
            buttonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            buttonLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configure(with title: String, isSelected: Bool) {
        buttonLabel.text = title
        
        if isSelected {
            contentView.backgroundColor = .white
            buttonLabel.textColor = .black
            contentView.layer.borderColor = UIColor.clear.cgColor
        } else {
            contentView.backgroundColor = UIColor(red: 35/255, green: 45/255, blue: 60/255, alpha: 1.0)
            buttonLabel.textColor = .white
            contentView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0).cgColor
        }
    }
}

