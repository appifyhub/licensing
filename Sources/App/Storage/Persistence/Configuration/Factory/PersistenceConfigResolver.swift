import Foundation
import Vapor

final class PersistenceConfigResolver {
    
    private static let DEFAULT_TYPE: PersistenceType = .mysql
    
    private static let KEY_DB_TYPE = "DB_TYPE"
    private static let KEY_DB_HOST = "DB_HOST"
    private static let KEY_DB_PORT = "DB_PORT"
    private static let KEY_DB_USER = "DB_USER"
    private static let KEY_DB_PASS = "DB_PASS"
    private static let KEY_DB_NAME = "DB_NAME"
    
    private init() {}
    
    static func resolve() -> PersistenceConfig {
        let envType = Environment.get(KEY_DB_TYPE)?.trim() ?? ""
        let resolvedType = PersistenceType.allCases.first { "\($0)" == envType } ?? DEFAULT_TYPE
        
        switch resolvedType {
            case .inmem:
                return InMemConfig()
            case .mysql:
                let envConfig = EnvironmentMySQLConfig(
                    rawHost: Environment.get(KEY_DB_HOST),
                    rawPort: Environment.get(KEY_DB_PORT),
                    rawUsername: Environment.get(KEY_DB_USER),
                    rawPassword: Environment.get(KEY_DB_PASS),
                    rawDatabaseName: Environment.get(KEY_DB_NAME)
                )
                if (envConfig.isValid()) { return envConfig }
        }
        return DebugMySQLConfig()
    }
    
}
