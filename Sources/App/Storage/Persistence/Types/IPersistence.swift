import Foundation
import NIO

protocol HasPersistenceKey {
    associatedtype KeyType
    
    var persistenceKey: KeyType { get }
}

class IPersistence<Model : HasPersistenceKey> {

    private let DEFAULT_LOOP = EmbeddedEventLoop()

    func create(_ model: Model) throws -> EventLoopFuture<Model> { notImplemented() }
    
    func read(_ key: Model.KeyType) throws -> EventLoopFuture<Model?> { notImplemented() }
    
    func update(_ model: Model) throws -> EventLoopFuture<Model> { notImplemented() }
    
    func delete(_ key: Model.KeyType) throws -> EventLoopFuture<Bool> { notImplemented() }
        
}

extension IPersistence {
    
    func error<T>(_ error: Error) -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newFailedFuture(error: error)
    }
    
    func success<T>(_ value: T) -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newSucceededFuture(result: value)
    }
    
    func notImplemented<T>() -> EventLoopFuture<T> {
        return DEFAULT_LOOP.newFailedFuture(error: "Not implemented.")
    }
    
}
