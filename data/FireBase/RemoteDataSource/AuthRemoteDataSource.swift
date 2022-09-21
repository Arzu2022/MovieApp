//
//  AuthRemoteDataSource.swift
//  data
//
//  Created by AziK's  MAC on 18.09.22.
//

import domain
import Alamofire

public class AuthRemoteDataSource: AuthRemoteDataSourceProtocol {
    let authProviderPro: AuthProviderProtocol
    init(authProviderPro: AuthProviderProtocol){
        self.authProviderPro = authProviderPro
    }
    
    public func loggedIn() -> Bool {
        return authProviderPro.isSignedIn()
    }
    
    public func register(credentials: AuthRegisterEntity) async throws {
        try await self.authProviderPro.createUser(username: credentials.username, email: credentials.email, password: credentials.password)
    }
    
    public func login(credentials: AuthInputEntity) async throws {
        try await self.authProviderPro.signin(email: credentials.email, password: credentials.password)
    }
    
    public func logout() throws {
        try self.authProviderPro.signout()
    }
    
    
    
}
