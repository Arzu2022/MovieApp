//
//  AuthRepo.swift
//  data
//
//  Created by AziK's  MAC on 19.09.22.
//

import Foundation
import domain
class AuthRepo: AuthRepoProtocol {
    
    private let remoteDataSource: AuthRemoteDataSourceProtocol
    
    init(remoteDataSource: AuthRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func isLeoggedIn() -> Bool {
        self.remoteDataSource.loggedIn()
    }
    
    func login(credentials: AuthInputEntity) async throws {
        try await self.remoteDataSource.login(credentials: credentials)
    }
    
    func logout() throws {
        try self.remoteDataSource.logout()
    }
    
    func register(credentials: AuthRegisterEntity) async throws {
        try await self.register(credentials: credentials)
    }
}
