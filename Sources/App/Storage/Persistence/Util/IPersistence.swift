import Foundation
import MySQL

private let NOT_IMPLEMENTED = "Not Implemented"
private let DEFAULT_LOOP = EmbeddedEventLoop()

/// This can't be a protocol because associatedTypes are nonsense.
class IPersistence<Key, Model : HasPersistenceKey, DB : DatabaseConnection> {
    
    func prepareCreate(model: Model) -> (DB) throws -> NIO.EventLoopFuture<Model> { return notImplemented() }
    
    func prepareRead(key: Key) -> (DB) throws -> NIO.EventLoopFuture<Model?> { return notImplemented() }
    
    func prepareUpdate(model: Model) -> (DB) throws -> NIO.EventLoopFuture<Model> { return notImplemented() }
    
    func prepareDelete(key: Key) -> (DB) throws -> NIO.EventLoopFuture<Bool> { return notImplemented() }
    
    // Helpers
    
    func notImplemented<T>() -> (DB) throws -> NIO.EventLoopFuture<T> {
        return { _ in DEFAULT_LOOP.newFailedFuture(error: NOT_IMPLEMENTED) }
    }
    
    func error<T>(_ error: Error) -> (DB) throws -> NIO.EventLoopFuture<T> {
        return { _ in DEFAULT_LOOP.newFailedFuture(error: error) }
    }
    
    func success<T>(_ value: T) -> (DB) throws -> NIO.EventLoopFuture<T> {
        return { _ in DEFAULT_LOOP.newSucceededFuture(result: value) }
    }
    
}

protocol HasPersistenceKey {
    associatedtype KeyType
    
    var persistenceKey: KeyType { get }
}
