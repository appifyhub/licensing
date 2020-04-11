import Foundation

private let DEF_PORT = 3306
private let MIN_PORT = 1025

struct EnvironmentMySQLConfig : MySQLConfig {
    
    let type: StorageType = .mysql
    
    let hostname: String
    let port: Int
    let username: String
    let password: String
    let database: String
    
    init(
        rawHost: String?,
        rawPort: String?,
        rawUsername: String?,
        rawPassword: String?,
        rawDatabaseName: String?
    ) {
        hostname = rawHost?.trim() ?? ""
        port = Int(rawPort?.trim() ?? "") ?? DEF_PORT
        username = rawUsername?.trim() ?? ""
        password = rawPassword?.trim() ?? ""
        database = rawDatabaseName?.trim() ?? ""
    }
    
    func isValid() -> Bool {
        return hostname.isNotBlank() &&
            port >= MIN_PORT &&
            username.isNotBlank() &&
            password.isNotBlank() &&
            database.isNotBlank()
    }
    
}
