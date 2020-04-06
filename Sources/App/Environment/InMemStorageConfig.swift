import Foundation

struct InMemStorageConfig : StorageConfig {
    
    let type: StorageType = .inmem
    
    func isValid() -> Bool {
        return true
    }
    
}
