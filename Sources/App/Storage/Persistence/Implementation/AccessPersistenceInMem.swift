import Foundation
import NIO

class AccessPersistenceInMem : IAccessPersistence {
    
    private var storage: [String : Access] = [:]
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Access) -> EventLoopFuture<Access> {
        if (model.token == nil) {
            return error("Token value cannot be auto-generated")
        }
        
        let newModel = model
            .withCurrentCreateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: String) -> EventLoopFuture<Access?> {
        return success(storage[key])
    }
    
    override func update(_ model: Access) -> EventLoopFuture<Access> {
        storage[model.persistenceKey] = model
        return success(model)
    }
    
    override func delete(_ key: String) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByAccountID(_ accountID: Int) throws -> EventLoopFuture<[Access]> {
        let result = filterValues { access in accountID == access.accountID }
        return success(result)
    }
    
    override func findOneByAccountID(_ accountID: Int) throws -> EventLoopFuture<Access?> {
        let result = filterValues { access in accountID == access.accountID }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (Access) -> Bool) -> [Access] {
        return storage.map { key, value -> Access in value }.filter(filter)
    }
    
}
