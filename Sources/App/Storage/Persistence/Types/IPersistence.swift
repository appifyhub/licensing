import Foundation
import NIO

protocol HasPersistenceKey {
    associatedtype KeyType
    
    var persistenceKey: KeyType { get }
}

class IPersistence<Model : HasPersistenceKey> {

    private let DEFAULT_LOOP = EmbeddedEventLoop()

    func create(_ model: Model) throws -> EventLoopFuture<Model> { unsupported() }
    
    func read(_ key: Model.KeyType) throws -> EventLoopFuture<Model?> { unsupported() }
    
    func update(_ model: Model) throws -> EventLoopFuture<Model> { unsupported() }
    
    func delete(_ key: Model.KeyType) throws -> EventLoopFuture<Bool> { unsupported() }
        
}

extension IPersistence {
    
    func error<T>(_ error: Error) -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newFailedFuture(error: error)
    }
    
    func success<T>(_ value: T) -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newSucceededFuture(result: value)
    }
    
    func unsupported<T>() -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newFailedFuture(error: "Unsupported operation.")
    }
    
}
