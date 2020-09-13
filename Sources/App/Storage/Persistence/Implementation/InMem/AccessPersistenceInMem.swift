import Foundation
import NIO

class AccessPersistenceInMem : IAccessPersistence {
    
    private var storage: [String : AccessDbm] = [:]
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AccessDbm) -> EventLoopFuture<AccessDbm> {
        if (model.token == nil) {
            return error("Token value cannot be auto-generated")
        }
        
        let newModel = model
            .withCurrentCreateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: String) -> EventLoopFuture<AccessDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: AccessDbm) -> EventLoopFuture<AccessDbm> {
        storage[model.persistenceKey] = model
        return success(model)
    }
    
    override func delete(_ key: String) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[AccessDbm]> {
        let result = filterValues { access in id == access.accountID }
        return success(result)
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<AccessDbm?> {
        let result = filterValues { access in id == access.accountID }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (AccessDbm) -> Bool) -> [AccessDbm] {
        return storage.map { key, value -> AccessDbm in value }.filter(filter)
    }
    
}
