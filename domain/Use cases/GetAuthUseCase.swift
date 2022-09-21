//
//  GetAuthUseCase.swift
//  domain
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation

public class GetAuthUseCase {
    private let repo:AuthRepoProtocol
    public init(repo:AuthRepoProtocol){
        self.repo = repo
    }
    public func execute(credentials: AuthInputEntity) async throws {
        try await self.repo.login(credentials: credentials)
    }
    public func execute(credentialsReg: AuthRegisterEntity) async throws {
        try await self.repo.register(credentials: credentialsReg)
    }
    public func execute() -> Bool {
        self.repo.isLeoggedIn()
    }
    public func executeOut() throws {
       try self.repo.logout()
    }
}
