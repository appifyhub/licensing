import Foundation

struct InMemConfig : PersistenceConfig {
    
    let type: StorageType = .inmem
    
    func isValid() -> Bool {
        return true
    }
    
}
