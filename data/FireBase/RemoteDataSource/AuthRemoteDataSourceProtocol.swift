//
//  AuthRemoteDataSourceProtocol.swift
//  data
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation
import domain
public protocol AuthRemoteDataSourceProtocol {
    func loggedIn() -> Bool
    func register(credentials: AuthRegisterEntity) async throws
    func login(credentials: AuthInputEntity) async throws
    func logout() throws
}
