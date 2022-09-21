//
//  AuthRepoProtocol.swift
//  domain
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation

public protocol AuthRepoProtocol {
    func isLeoggedIn() -> Bool
    func login(credentials: AuthInputEntity) async throws
    func register(credentials: AuthRegisterEntity) async throws
    func logout() throws
}
