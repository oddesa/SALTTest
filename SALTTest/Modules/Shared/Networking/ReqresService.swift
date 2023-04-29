//
//  ReqresService.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import Foundation
import Moya

public enum ReqresService {
    static func getProvider() -> MoyaProvider<ReqresService> {
        return MoyaProvider<ReqresService>()
    }

    case login(email: String, password: String)
    case getUsers(page: Int)
}

extension ReqresService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://reqres.in/api/")!
    }
    
    public var path: String {
        switch self {
        case .login(_, _):
            return "login"
        case .getUsers(_):
            return "users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password],
                                      encoding: JSONEncoding.default)
        case .getUsers(let page):
            return .requestParameters(parameters: ["page": page],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}



