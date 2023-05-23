//
//  SearchVC.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 23/05/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let textfield = YBTextField()
    let ctaButton = YBButton(backgroundColor: .blue, title: "Search Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(logoImageView, textfield, ctaButton)
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCtaButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "flickr")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func configureTextField() {
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCtaButton() {
        ctaButton.addTarget(self, action: #selector(pushListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    @objc func pushListVC() {
        print("tapped")
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushListVC()
        return true
    }
}
