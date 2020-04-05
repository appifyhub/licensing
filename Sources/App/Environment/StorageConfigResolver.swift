import Foundation
import Vapor

final class StorageConfigResolver {
    
    private init() {}
    
    static func resolve() -> StorageConfig {
        let config: StorageConfig
        let envType = Environment.get(StorageType.KEY_ENVIRONMENT)?.trim() ?? ""
        let resolvedType = StorageType.resolve(envType)
        
        switch resolvedType {
            case .inmem:
                config = InMemStorageConfig()
            case .mysql:
                let envConfig = EnvironmentMySQLConfig()
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
    
    static let KEY_ENVIRONMENT = "STORAGE_TYPE"
    private static let DEF_TYPE = StorageType.inmem
    
    static func resolve(_ name: String) -> StorageType {
        return self.allCases.first { "\($0)" == name } ?? DEF_TYPE
    }
    
}
