//
//  SettingsViewController.swift
//  QR Scanner
//
//  Created by Swarup Panda on 04/10/24.
//

import UIKit

class FormViewController: UIViewController {
        
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logoImageView = UIImageView()
    private let label1 = UILabel()
    private var submitButton: UIButton!
    
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let mobileTextField = UITextField()
    private let companyTextField = UITextField()
    private let inputTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradientWithBlackBackground()
        setupScrollView()
        setupUI()
        setupGesturesAndObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupUI() {
        companyLogo()
        companyName()
        getInTouch()
        setupTextFields()
        createSubmitButton()
    }
    
    private func companyLogo() {
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            logoImageView.heightAnchor.constraint(equalToConstant: 65),
            logoImageView.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func companyName() {
        let label = UILabel()
        label.text = "Effectization\nStudio"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 13),
        ])
    }
    
    private func getInTouch() {
        label1.text = "GET IN TOUCH"
        label1.textColor = .white
        label1.textAlignment = .left
        label1.numberOfLines = 2
        label1.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label1)
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupTextFields() {
        let textFields = [nameTextField, emailTextField, mobileTextField, companyTextField, inputTextField]
        let placeholders = ["Name", "Email", "Mobile", "Company", "Input"]
        
        for (index, textField) in textFields.enumerated() {
            textField.placeholder = placeholders[index]
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .clear
            textField.textColor = .white
            textField.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(textField)
        }
        
        emailTextField.keyboardType = .emailAddress
        mobileTextField.keyboardType = .phonePad
        
        let stackView = UIStackView(arrangedSubviews: textFields)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        textFields.forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
        inputTextField.heightAnchor.constraint(equalToConstant: 88).isActive = true
    }
    
    private func createSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.layer.borderWidth = 1.0
        submitButton.layer.borderColor = UIColor.clear.cgColor
        submitButton.layer.cornerRadius = 25
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(submitButton)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.purple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        gradientLayer.cornerRadius = 25
        
        submitButton.layer.insertSublayer(gradientLayer, at: 0)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            submitButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 30),
            submitButton.widthAnchor.constraint(equalToConstant: 120),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        submitButton.layoutIfNeeded()
        gradientLayer.frame = submitButton.bounds
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
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    @objc private func submitButtonTapped() {
        submitForm()
    }
    
    private func submitForm() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let mobile = mobileTextField.text, !mobile.isEmpty,
              let company = companyTextField.text, !company.isEmpty,
              let input = inputTextField.text, !input.isEmpty else {
            showAlert(title: "Error", message: "Please fill all fields")
            return
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else {
            showAlert(title: "Error", message: "Please enter a valid email address")
            return
        }
        
        let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfClex9nKG4kwd4P8BwrOQYrqGtGpFQ5lRILzqGsbjk9ysoXw/formResponse")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "entry.1679889079=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.1637328801=\(email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.512556672=\(mobile.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.1973837667=\(company.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.1361717107=\(input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        request.httpBody = postString.data(using: .utf8)
        
        submitButton.isEnabled = false
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.submitButton.isEnabled = true
                
                if let error = error {
                    self?.showAlert(title: "Error", message: "Failed to submit form: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self?.showAlert(title: "Error", message: "Failed to submit form. Please try again later.")
                    return
                }
                
                self?.showAlert(title: "Success", message: "Form submitted successfully") {
                    self?.clearFormFields()
                }
            }
        }
        task.resume()
    }
    
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completion?() })
        present(alert, animated: true, completion: nil)
    }
    
    private func clearFormFields() {
        nameTextField.text = ""
        emailTextField.text = ""
        mobileTextField.text = ""
        companyTextField.text = ""
        inputTextField.text = ""
    }
    
    
    private func setupGesturesAndObservers() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = view.frame
            aRect.size.height -= keyboardSize.height
            
            if let activeField = view.findFirstResponder() as? UITextField {
                if !aRect.contains(activeField.frame.origin) {
                    scrollView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}

