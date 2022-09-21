


protocol AuthProviderProtocol {
    func isSignedIn() -> Bool
    func createUser(username: String,email: String, password: String) async throws
    func signin(email: String, password: String) async throws
    func signout() throws
    
}
