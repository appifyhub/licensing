import Foundation

struct DevMySQLConfig : MySQLConfig {
    
    let type: StorageType = .mysql
    
    let hostname: String = "localhost"
    let port: Int = 3306
    let username: String = "root"
    let password: String = "12345678"
    let database: String = "licensing"
    
    func isValid() -> Bool {
        return true
    }
    
}
