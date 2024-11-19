//
//  HomeViewController.swift
//  QR Scanner
//
//  Created by Swarup Panda on 04/10/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let companyName = UILabel()
    let qrButton = UIButton()
    let centerImage = UIImageView()
    let centerImage2 = UIImageView()
    
    private var collectionView: UICollectionView!
    private let buttonTitles = ["AR", "CGI", "Web Apps", "VR", "Other", "Testing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        setupScrollView()
        setupContentView()
        companyLabel()
        setupQRScannerButton()
        horizontalScrollView()
        setupFirstImageView()
        setupSecondImageView()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func companyLabel() {
        let text = "Effectization\nStudio"
        let attributedText = NSMutableAttributedString(string: text)
        let lightYellow = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0)
        
        attributedText.addAttribute(.foregroundColor, value: lightYellow, range: (text as NSString).range(of: "Effectization"))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: (text as NSString).range(of: "Studio"))
        
        companyName.attributedText = attributedText
        companyName.textAlignment = .left
        companyName.numberOfLines = 2
        companyName.font = UIFont.boldSystemFont(ofSize: 36)
        companyName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(companyName)
        
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            companyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        ])
    }
    
    private func setupQRScannerButton() {
        qrButton.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        qrButton.tintColor = .white
        qrButton.backgroundColor = .darkGray
        qrButton.layer.cornerRadius = 27.5
        qrButton.clipsToBounds = true
        qrButton.imageView?.contentMode = .scaleAspectFill
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(qrButton)
        
        NSLayoutConstraint.activate([
            qrButton.widthAnchor.constraint(equalToConstant: 55),
            qrButton.heightAnchor.constraint(equalToConstant: 55),
            qrButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            qrButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        
        qrButton.addTarget(self, action: #selector(didTapQRScanner), for: .touchUpInside)
    }
    
    @objc private func didTapQRScanner() {
        let qrViewController = QRViewController()
        present(qrViewController, animated: true)
    }
    
    private func horizontalScrollView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(HorizontalButtonCell.self, forCellWithReuseIdentifier: "HorizontalButtonCell")
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFirstImageView() {
        centerImage.image = UIImage(named: "filter")
        centerImage.contentMode = .scaleAspectFill
        centerImage.layer.cornerRadius = 45
        centerImage.clipsToBounds = true
        centerImage.translatesAutoresizingMaskIntoConstraints = false
            
        contentView.addSubview(centerImage)

        NSLayoutConstraint.activate([
            centerImage.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            centerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            centerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            centerImage.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func setupSecondImageView() {
        centerImage2.image = UIImage(named: "filter")
        centerImage2.contentMode = .scaleAspectFill
        centerImage2.layer.cornerRadius = 45
        centerImage2.clipsToBounds = true
        centerImage2.translatesAutoresizingMaskIntoConstraints = false
            
        contentView.addSubview(centerImage2)

        NSLayoutConstraint.activate([
            centerImage2.topAnchor.constraint(equalTo: centerImage.bottomAnchor, constant: 20),
            centerImage2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            centerImage2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            centerImage2.heightAnchor.constraint(equalToConstant: 500),
            centerImage2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            centerImage2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 120)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalButtonCell", for: indexPath) as! HorizontalButtonCell
        cell.configure(with: buttonTitles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = buttonTitles[indexPath.item]
        let width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 32
        return CGSize(width: width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(buttonTitles[indexPath.item]) tapped")
    }
}
