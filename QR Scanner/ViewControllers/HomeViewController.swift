//
//  HomeViewController.swift
//  QR Scanner
//
//  Created by Swarup Panda on 04/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let companyName = UILabel()
    let qrButton = UIButton()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        addGradientWithBlackBackground()
        setupScrollView()
        setupContentView()
        companyLabel()
        setupQRScannerButton()
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
        
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor).isActive = true
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
            companyName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            companyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        ])
    }
    
    private func setupQRScannerButton() {
        qrButton.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        qrButton.tintColor = .white
        
        qrButton.backgroundColor = .systemGray6
        qrButton.layer.cornerRadius = 27.5
        qrButton.clipsToBounds = true
        qrButton.imageView?.contentMode = .scaleAspectFill
        
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(qrButton)
        
        NSLayoutConstraint.activate([
            qrButton.widthAnchor.constraint(equalToConstant: 55),
            qrButton.heightAnchor.constraint(equalToConstant: 55),
            qrButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            qrButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        
        qrButton.addTarget(self, action: #selector(didTapQRScanner), for: .touchUpInside)
    }

    @objc private func didTapQRScanner() {
        let qrViewController = QRViewController()
        qrViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(qrViewController, animated: true)
    }


    private func addGradientWithBlackBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.systemPink.withAlphaComponent(0.7).cgColor,
            UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor.purple.withAlphaComponent(0.7).cgColor
        ]
        
        gradientLayer.locations = [0.0, 0.2, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = view.bounds
        
        view.layer.addSublayer(gradientLayer)
    }
}



