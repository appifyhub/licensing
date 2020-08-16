import Foundation
import Vapor
import MySQL

extension Service : SQLTable {}

class ServicePersistenceMySQL : IServicePersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Service) throws -> EventLoopFuture<Service> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: Service.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<Service?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Service.self)
                .where(\Service.ID == key)
                .limit(1)
                .all(decoding: Service.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: Service) throws -> EventLoopFuture<Service> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(Service.self)
                .set(newModel)
                .where(\Service.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: Service.self)
                .where(\Service.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findOneByName(_ name: String) throws -> EventLoopFuture<Service?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Service.self)
                .where(\Service.name == name)
                .limit(1)
                .all(decoding: Service.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
