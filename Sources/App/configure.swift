import Vapor
import MySQL

/// Called before the application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Initialize storage (in-mem or DB)
    try configureStorage(&services)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
}

private func configureStorage(_ services: inout Services) throws {
    let storageConfig = StorageConfigResolver.resolve()
    switch storageConfig {
        case is SQLConfig:
            let sqlConfig = storageConfig as! SQLConfig
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
                    
                    print("Initialized with SQL storage: \(sqlConfig)")
                default:
                    throw "Unknown SQL config: \(sqlConfig)"
            }
        default:
            print("Initialized with non-SQL storage: \(storageConfig)")
    }
}
