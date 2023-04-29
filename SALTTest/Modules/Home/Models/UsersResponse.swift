//
//  UsersResponse.swift
//  SALTTest
//
//  Created by Jehnsen Hirena Kane on 29/04/23.
//

import Foundation

struct UsersResponse: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [User]?
}

struct User: Codable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?

}
