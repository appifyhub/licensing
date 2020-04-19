import Foundation
import MySQL

final class InMemoryConnection : DatabaseConnection {
    
    typealias Database = InMemStorage
    
    final class InMemStorage : DatabaseKit.Database {
        typealias Connection = InMemoryConnection
        
        func newConnection(on worker: Worker) -> NIO.EventLoopFuture<Connection> {
            let eventLoop = worker.eventLoop
            return eventLoop.newSucceededFuture(result: InMemoryConnection(eventLoop))
        }
    }
    
    let eventLoop: EventLoop
    let isClosed: Bool = false
    var extend: Extend = Extend()
    
    init(_ eventLoop: EventLoop) {
        self.eventLoop = eventLoop
    }
    
    func close() { }
    
    func next() -> EventLoop { return eventLoop }
    
    func shutdownGracefully(queue: DispatchQueue, _ callback: @escaping (Error?) -> Void) { }
    
}
