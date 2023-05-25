//
//  SearchVC.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 23/05/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - UI Components
    let logoImageView = UIImageView()
    let textfield = YBTextField()
    let ctaButton = YBButton(backgroundColor: .blue, title: "Search Photos")
    
    // MARK: - Properties
    private let viewModel: SearchViewModel
    
    // MARK: - Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(logoImageView, textfield, ctaButton)
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCtaButton()
        createDismissKeyboardTapGesture()
    }
    
    // MARK: - Configure subviews
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
        ctaButton.addTarget(self, action: #selector(ctaTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    @objc func ctaTapped() {
        guard let tag = textfield.text else {
            print("no tag entered")
            return
        }
        viewModel.didTapSearch(tag: tag)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.didTapSearch(tag: "")
        return true
    }
}
