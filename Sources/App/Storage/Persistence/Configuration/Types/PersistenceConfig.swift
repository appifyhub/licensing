import Foundation

enum PersistenceType : String, CaseIterable {
    case mysql = "mysql"
    case inmem = "inmem"
}

/// Basic config, holds the type
protocol PersistenceConfig {
    var type: PersistenceType { get }
}

// SQL-specific config
protocol SQLConfig : PersistenceConfig {
    
    var hostname: String { get }
    var port: Int { get }
    var username: String { get }
    var password: String { get }
    var database: String { get }
    
    func isValid() -> Bool
    
}

/// Marker for MySQL
protocol MySQLConfig : SQLConfig { }
