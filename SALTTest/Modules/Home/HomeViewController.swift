//
//  HomeViewController.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var usersTableView: UITableView = {
        let view = UITableView()
        view.register(cellWithClass: UsersTableViewCell.self)
        view.rowHeight = 76
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewModel: HomeViewModel = {
        let view = HomeViewModel()
        view.onFinishGetUsers = { [weak self] error in
            self?.didFinishGetUsers(error)
        }
        return view
    }()
    
    private lazy var logoutBarButton: UIButton = {
        let view = UIButton()
        view.setTitle("Logout", for: .normal)
        view.backgroundColor = .clear
        view.setTitleColor(UIColor.systemRed, for: .normal)
        view.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutBarButton)
        view.backgroundColor = .white
        setupLayout()
        viewModel.getUsers()
    }
    
    @objc private func logout() {
        self.dismiss(animated: true)
    }
    
    private func didFinishGetUsers(_ message: String?) {
        guard message == nil else {
            self.popupAlert(title: "Error", message: message ?? "Please try again later")
            return
        }
        usersTableView.reloadData()
    }
    
    private func setupLayout() {
        view.addSubview(usersTableView)
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.alreadyFetchAllData == false ? viewModel.users.count + 1 : viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UsersTableViewCell.self)
        if isLoadingCell(for: indexPath) {
            cell.showLoadingView()
        } else {
            cell.setupContent(data: viewModel.users[indexPath.row])
        }
        return cell

    }
    
    
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard viewModel.alreadyFetchAllData == false else { return }
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getUsers()
        }
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.users.count
    }
}
