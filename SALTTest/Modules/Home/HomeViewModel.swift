//
//  HomeViewModel.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import Foundation

final class HomeViewModel {
    let provider = ReqresService.getProvider()
    var currentPage = 1
    var users = [User]()
    var alreadyFetchAllData = false
    
    var onFinishGetUsers: ((_ error: String?) -> Void)?
    
    func getUsers() {
        guard alreadyFetchAllData == false else {
            return
        }
        provider.request(.getUsers(page: currentPage)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do {
                    let mappedResponse = try response.map(UsersResponse.self)
                    guard let users = mappedResponse.data, !users.isEmpty else {
                        self.alreadyFetchAllData = true
                        self.onFinishGetUsers?(nil)
                        return
                    }
                    self.currentPage += 1
                    self.users.append(contentsOf: users)
                    self.onFinishGetUsers?(nil)
                    if self.currentPage == 2 {
                        getUsers()
                    }
                } catch {
                    self.onFinishGetUsers?(error.localizedDescription)
                }
            case .failure(let error):
                self.onFinishGetUsers?(error.localizedDescription)
            }
        }
    }
}
