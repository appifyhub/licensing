import Vapor
import MySQL

/// Called before the application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Initialize persistence (in-mem or DB)
    let cacheConfig = configureCache()
    let persistenceConfig = try configurePersistence(&services)
    let timeProvider = configureTime()
    try DI.configure(cacheConfig, persistenceConfig, timeProvider)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    services.register(middlewares)
}

private func configurePersistence(_ services: inout Services) throws -> PersistenceConfig {
    let persistenceConfig = PersistenceConfigResolver.resolve()
    switch persistenceConfig {
        case is SQLConfig:
            try MySQLInitializer.initialize(sqlConfig: persistenceConfig as! SQLConfig, services: &services)
        default:
            print("Initialized with non-SQL persistence: \(persistenceConfig)")
    }
    return persistenceConfig
}

private func configureCache() -> CacheConfig {
    return CacheConfigResolver.resolve()
}

private func configureTime() -> TimeProvider {
    return SystemTimeProvider()
}
