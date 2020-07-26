import Foundation

struct InMemConfig : PersistenceConfig {
    
    let type: PersistenceType = .inmem
    
    func isValid() -> Bool {
        return true
    }
    
}
