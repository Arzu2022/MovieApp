//
//  AuthRegisterEntity.swift
//  domain
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation

public struct AuthRegisterEntity {
   public let username: String
   public let email: String
   public let password: String
    //let image: Data
    public init(
        username: String,
        email: String,
        password: String
    ){
        self.username = username
        self.email = email
        self.password = password
    }
    
}
