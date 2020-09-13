import Foundation
import NIO

extension PropertyDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IPropertyPersistence : IPersistence<PropertyDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[PropertyDbm]> { unsupported() }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[PropertyDbm]> { unsupported() }
    
    func findAllByType(_ type: PropertyDbm.PropertyType) throws -> NIO.EventLoopFuture<[PropertyDbm]> { unsupported() }
    
    func findAllByMandatory(_ mandatory: Bool) throws -> NIO.EventLoopFuture<[PropertyDbm]> { unsupported() }
    
}
