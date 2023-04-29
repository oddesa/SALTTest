//
//  LoginViewController.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.tintColor = .systemBlue
        view.hidesWhenStopped = true
        view.isHidden = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "ic_salt")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.borderStyle = .roundedRect
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.placeholder = "Email"
        view.text = "eve.holt@reqres.in"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.borderStyle = .roundedRect
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.placeholder = "Password"
        view.text = "cityslicka"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewModel: LoginViewModel = {
        let viewModel = LoginViewModel()
        viewModel.onFinishLogin = { [weak self] error in
            self?.didFinishLogin(error)
        }
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .white
    }
    
    @objc private func login() {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty
        else {
            self.popupAlert(title: "Password and Email cant be empty", message: "Please fill the password and email")
            return
        }
        viewModel.login(email: email, password: password)
        loadingView.startAnimating()
    }
    
    private func didFinishLogin(_ message: String?) {
        loadingView.stopAnimating()
        guard message == nil else{
            self.popupAlert(title: "Error", message: message ?? "Please try again later")
            return
        }
        let navVC = UINavigationController(rootViewController: HomeViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func setupLayout() {
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -32),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
