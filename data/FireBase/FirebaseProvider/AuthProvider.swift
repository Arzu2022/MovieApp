//
//  AuthProvider.swift
//  data
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation
import FirebaseAuth
public class AuthProvider:AuthProviderProtocol {
    private let auth = FirebaseAuth.Auth.auth()
    
    func isSignedIn() -> Bool {
        self.auth.currentUser != nil
    }
    
    func createUser(username: String,email: String, password: String) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            self.auth.createUser(withEmail: email, password: password) { result, error in
                if let _ = result {
                    continuation.resume(returning: Void())
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: NSError(domain: "Auth-CreateUser", code: 1))
                }
            }
        }
    }
    
    func signin(email: String, password: String) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            self.auth.signIn(withEmail: email, password: password) { result, error in
                if let _ = result {
                    continuation.resume(returning: Void())
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: NSError(domain: "Auth-Signin", code: 2))
                }
            }
        }
    }
    
    func signout() throws {
        try self.auth.signOut()
    }
    
    
    
    
    
}
