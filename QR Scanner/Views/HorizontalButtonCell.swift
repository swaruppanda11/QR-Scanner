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
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(buttonLabel)
        
        // Set the background color to a dark grayish blue
        contentView.backgroundColor = UIColor(red: 35/255, green: 45/255, blue: 60/255, alpha: 1.0) 
        contentView.layer.cornerRadius = 22.5
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            buttonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            buttonLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configure(with title: String) {
        buttonLabel.text = title
    }
}