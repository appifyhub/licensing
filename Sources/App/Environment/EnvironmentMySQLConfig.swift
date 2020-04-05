import Foundation
import Vapor

struct EnvironmentMySQLConfig : MySQLConfig {
    
    static let KEY_DB_HOST = "DB_HOST"
    static let KEY_DB_PORT = "DB_PORT"
    static let KEY_DB_USER = "DB_USER"
    static let KEY_DB_PASS = "DB_PASS"
    static let KEY_DB_NAME = "DB_NAME"
    static let DEF_PORT = 3306
    static let MIN_PORT = 1025
    
    let type: StorageType = .mysql
    
    let hostname: String
    let port: Int
    let username: String
    let password: String
    let database: String
    
    init() {
        let envHost = Environment.get(EnvironmentMySQLConfig.KEY_DB_HOST)?.trim() ?? ""
        if (envHost.isNotBlank()) {
            hostname = envHost
        } else {
            hostname = ""
        }
        
        let envPort = Environment.get(EnvironmentMySQLConfig.KEY_DB_PORT)?.trim() ?? ""
        if (envPort.isNotBlank()) {
            port = Int(envPort) ?? EnvironmentMySQLConfig.DEF_PORT
        } else {
            port = EnvironmentMySQLConfig.DEF_PORT
        }
        
        let envUser = Environment.get(EnvironmentMySQLConfig.KEY_DB_USER)?.trim() ?? ""
        if (envUser.isNotBlank()) {
            username = envUser
        } else {
            username = ""
        }
        
        let envPass = Environment.get(EnvironmentMySQLConfig.KEY_DB_PASS)?.trim() ?? ""
        if (envPass.isNotBlank()) {
            password = envPass
        } else {
            password = ""
        }
        
        let envName = Environment.get(EnvironmentMySQLConfig.KEY_DB_NAME)?.trim() ?? ""
        if (envName.isNotBlank()) {
            database = envName
        } else {
            database = ""
        }
    }
    
    func isValid() -> Bool {
        return hostname.isNotBlank() &&
            port >= EnvironmentMySQLConfig.MIN_PORT &&
            username.isNotBlank() &&
            password.isNotBlank() &&
            database.isNotBlank()
    }
    
}
