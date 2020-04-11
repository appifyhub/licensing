import Foundation
import Vapor

final class StorageConfigResolver {
    
    private static let DEFAULT_TYPE = StorageType.inmem
    
    private static let KEY_DB_TYPE = "DB_TYPE"
    private static let KEY_DB_HOST = "DB_HOST"
    private static let KEY_DB_PORT = "DB_PORT"
    private static let KEY_DB_USER = "DB_USER"
    private static let KEY_DB_PASS = "DB_PASS"
    private static let KEY_DB_NAME = "DB_NAME"
    
    private init() {}
    
    static func resolve() -> StorageConfig {
        let config: StorageConfig
        let envType = Environment.get(KEY_DB_TYPE)?.trim() ?? ""
        let resolvedType = StorageType.resolve(envType, defaultType: DEFAULT_TYPE)
        
        switch resolvedType {
            case .inmem:
                config = InMemStorageConfig()
            case .mysql:
                let envConfig = EnvironmentMySQLConfig(
                    rawHost: Environment.get(KEY_DB_HOST),
                    rawPort: Environment.get(KEY_DB_PORT),
                    rawUsername: Environment.get(KEY_DB_USER),
                    rawPassword: Environment.get(KEY_DB_PASS),
                    rawDatabaseName: Environment.get(KEY_DB_NAME)
                )
                if (envConfig.isValid()) {
                    config = envConfig
                } else {
                    config = DevMySQLConfig()
                }   
        }
        
        return config
    }
    
}

private extension StorageType {
    
    static func resolve(_ name: String, defaultType: StorageType) -> StorageType {
        return self.allCases.first { "\($0)" == name } ?? defaultType
    }
    
}
