import Foundation
import NIO

extension Property : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IPropertyPersistence : IPersistence<Property> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[Property]> { unsupported() }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[Property]> { unsupported() }
    
    func findAllByType(_ type: Property.PropertyType) throws -> NIO.EventLoopFuture<[Property]> { unsupported() }
    
    func findAllByMandatory(_ mandatory: Bool) throws -> NIO.EventLoopFuture<[Property]> { unsupported() }
    
}
