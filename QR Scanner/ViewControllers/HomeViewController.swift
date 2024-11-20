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
    
    private var collectionView: UICollectionView!
    private let buttonTitles = ["AR", "CGI", "Web Apps", "AI"]
    private var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
        setupScrollView()
        setupContentView()
        setupCompanyLabel()
        setupQRScannerButton()
        setupHorizontalScrollView()
        
        // Set AR button as selected by default
        let defaultIndex = IndexPath(item: 0, section: 0) // AR button is at index 0
        selectedIndex = defaultIndex
        collectionView.selectItem(at: defaultIndex, animated: false, scrollPosition: .centeredHorizontally)
        collectionView.reloadData()
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
    
    private func setupCompanyLabel() {
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
        qrButton.backgroundColor = UIColor(red: 35/255, green: 45/255, blue: 60/255, alpha: 1.0)
        qrButton.layer.cornerRadius = 25
        qrButton.clipsToBounds = true
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(qrButton)
        
        NSLayoutConstraint.activate([
            qrButton.widthAnchor.constraint(equalToConstant: 50),
            qrButton.heightAnchor.constraint(equalToConstant: 50),
            qrButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            qrButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        
        qrButton.addTarget(self, action: #selector(didTapQRScanner), for: .touchUpInside)
    }
    
    @objc private func didTapQRScanner() {
        let qrViewController = QRViewController()
        present(qrViewController, animated: true)
    }
    
    private func setupHorizontalScrollView() {
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
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalButtonCell", for: indexPath) as! HorizontalButtonCell
        cell.configure(with: buttonTitles[indexPath.item], isSelected: indexPath == selectedIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = buttonTitles[indexPath.item]
        let width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 32
        return CGSize(width: width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath {
            selectedIndex = indexPath
            collectionView.reloadData()
        }
        print("\(buttonTitles[indexPath.item]) tapped")
    }
}
