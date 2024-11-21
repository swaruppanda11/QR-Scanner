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
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private let imageUrlsForButtons: [String: [String]] = [
        "AR": [
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/1.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png"
        ],
        "CGI": [
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png"
        ],
        "Web Apps": [
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png"
        ],
        "AI": [
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
            "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png"
        ]
    ]
    
    private var imageContainerView: UIView!
    private var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
        setupScrollView()
        setupContentView()
        setupCompanyLabel()
        setupQRScannerButton()
        setupHorizontalScrollView()
        setupImageViews()
        
        let defaultIndex = IndexPath(item: 0, section: 0)
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
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupImageViews() {
        imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageContainerView)
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        updateImageViews(for: "AR")
    }
    
    private func updateImageViews(for category: String) {
        imageContainerView.subviews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
        
        guard let imageUrls = imageUrlsForButtons[category] else { return }
        
        var lastAnchor: NSLayoutYAxisAnchor? = imageContainerView.topAnchor
        
        for url in imageUrls {
            let imageView = addImageView(with: url, below: lastAnchor, in: imageContainerView)
            imageViews.append(imageView)
            lastAnchor = imageView.bottomAnchor
        }
        
        if let lastAnchor = lastAnchor {
            imageContainerView.bottomAnchor.constraint(equalTo: lastAnchor, constant: 20).isActive = true
            contentView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    private func addImageView(with urlString: String, below anchor: NSLayoutYAxisAnchor?, in containerView: UIView) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .gray
        
        let infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        infoButton.tintColor = UIColor.black
        infoButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1)
        infoButton.layer.cornerRadius = 30
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Make Up TryOn"
        buttonLabel.textColor = .white
        buttonLabel.textAlignment = .left
        buttonLabel.numberOfLines = 2
        buttonLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        buttonLabel.clipsToBounds = true
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let imageTitle = UILabel()
        imageTitle.text = "Snapchat Filters  "
        imageTitle.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1)
        imageTitle.textAlignment = .center
        imageTitle.numberOfLines = 2
        imageTitle.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        imageTitle.clipsToBounds = true
        imageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.translatesAutoresizingMaskIntoConstraints = false
        blurredView.layer.cornerRadius = 30 // Set desired corner radius
        blurredView.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = blurredView.bounds
        gradientLayer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor,
            UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.7).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        blurredView.layer.insertSublayer(gradientLayer, at: 0)
        
        infoButton.addTarget(self, action: #selector(openWikipediaLink), for: .touchUpInside)
        
        blurredView.contentView.addSubview(imageTitle)
        
        containerView.addSubview(imageView)
        containerView.addSubview(infoButton)
        containerView.addSubview(buttonLabel)
        containerView.addSubview(blurredView)
        
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: anchor ?? containerView.topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 500),
            
            infoButton.widthAnchor.constraint(equalToConstant: 60),
            infoButton.heightAnchor.constraint(equalToConstant: 60),
            infoButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            infoButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            
            buttonLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25),
            buttonLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            buttonLabel.heightAnchor.constraint(equalToConstant: 50),
            
            imageTitle.centerXAnchor.constraint(equalTo: blurredView.centerXAnchor),
            imageTitle.centerYAnchor.constraint(equalTo: blurredView.centerYAnchor),
            imageTitle.leadingAnchor.constraint(equalTo: blurredView.leadingAnchor, constant: 20),
            imageTitle.trailingAnchor.constraint(equalTo: blurredView.trailingAnchor, constant: -20),
            
            blurredView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 27),
            blurredView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            blurredView.trailingAnchor.constraint(equalTo: imageTitle.trailingAnchor),
            blurredView.bottomAnchor.constraint(equalTo: imageTitle.bottomAnchor),
            blurredView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        if let anchor = anchor {
            imageView.topAnchor.constraint(equalTo: anchor, constant: 20).isActive = true
        } else {
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            imageView.image = cachedImage
            return imageView
        }
        
        guard let url = URL(string: urlString) else { return imageView }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else { return }
            
            self?.imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
        
        return imageView
    }
    
    @objc private func openWikipediaLink() {
        guard let url = URL(string: "https://en.wikipedia.org/wiki/Augmented_reality") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
        let widestWidth = buttonTitles.map { title in
            title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 32
        }.max() ?? 100
        
        return CGSize(width: widestWidth, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath {
            selectedIndex = indexPath
            let selectedCategory = buttonTitles[indexPath.item]
            
            UIView.transition(with: imageContainerView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.imageViews.forEach { $0.removeFromSuperview() }
                self.imageViews.removeAll()
                
                self.updateImageViews(for: selectedCategory)
            }, completion: nil)
            
            collectionView.reloadData()
        }
        print("\(buttonTitles[indexPath.item]) tapped")
    }
}
