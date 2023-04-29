//
//  LoginViewModel.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import Foundation

final class LoginViewModel {
    let provider = ReqresService.getProvider()
    
    var onFinishLogin: ((_ error: String?) -> Void)?
    
    func login(email: String, password: String) {
        provider.request(.login(email: email, password: password)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let _ = try response.map(LoginResponse.self)
                    // Ignore the token received
                    self.onFinishLogin?(nil)
                } catch {
                    self.onFinishLogin?(error.localizedDescription)
                }
            case .failure(let error):
                self.onFinishLogin?(error.localizedDescription)
            }
        }
    }
}
