//
//  UsersTableViewCell.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.backgroundColor = .white
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        containerView.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: containerView.topAnchor),
        ])
        
        containerView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        containerView.addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -2),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            fullNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
        
        containerView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    func setupContent(data: User) {
        loadingView.stopAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2
        }
        
        avatarImageView.setImageWithPlaceholder(url: URL(string: data.avatar ?? "NoAvatar"),
                                                systemPlaceholder: "person.fill")
        fullNameLabel.text = (data.first_name ?? "John") + " " + (data.last_name ?? "Doe")
        emailLabel.text = data.email
    }
    
    func showLoadingView() {
        loadingView.startAnimating()
    }

}
