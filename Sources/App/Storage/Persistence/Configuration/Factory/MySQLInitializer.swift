import Foundation
import Vapor
import MySQL

final class MySQLInitializer {
    
    static func initialize(sqlConfig: SQLConfig, services: inout Services) throws {
        switch sqlConfig {
            case is MySQLConfig:
                // Register external providers first (i.e. for database access)
                try services.register(MySQLProvider())
                
                // Configure a MySQL database
                let mysql = MySQLDatabase(
                    config: MySQLDatabaseConfig(
                        hostname: sqlConfig.hostname,
                        port: sqlConfig.port,
                        username: sqlConfig.username,
                        password: sqlConfig.password,
                        database: sqlConfig.database,
                        capabilities: MySQLCapabilities.default,
                        characterSet: MySQLCharacterSet.utf8_general_ci,
                        transport: MySQLTransportConfig.unverifiedTLS
                    )
                )
                
                /// Register the configured MySQL database to the database config
                var database = DatabasesConfig()
                database.add(database: mysql, as: .mysql)
                services.register(database)
                
                print("Initialized with SQL persistence: \(sqlConfig)")
            default:
                throw "Unknown SQL config: \(sqlConfig)"
        }
    }
    
}
