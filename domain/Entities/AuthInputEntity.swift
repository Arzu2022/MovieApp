//
//  AuthInputEntity.swift
//  domain
//
//  Created by AziK's  MAC on 18.09.22.
//

import Foundation

public struct AuthInputEntity {
    public let email: String
    public let password: String
    public init(
         email: String,
         password: String
     ){
         self.email = email
         self.password = password
     }
     
}
