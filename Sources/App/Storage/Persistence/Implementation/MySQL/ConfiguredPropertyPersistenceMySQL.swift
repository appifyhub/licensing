import Foundation
import Vapor
import MySQL

extension ConfiguredProperty : SQLTable {}

class ConfiguredPropertyPersistenceMySQL : IConfiguredPropertyPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ConfiguredProperty) throws -> EventLoopFuture<ConfiguredProperty> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: ConfiguredProperty.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<ConfiguredProperty?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.ID == key)
                .limit(1)
                .all(decoding: ConfiguredProperty.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: ConfiguredProperty) throws -> EventLoopFuture<ConfiguredProperty> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(ConfiguredProperty.self)
                .set(newModel)
                .where(\ConfiguredProperty.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: ConfiguredProperty.self)
                .where(\ConfiguredProperty.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByAssignedService(id: Int) throws -> EventLoopFuture<[ConfiguredProperty]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.assignedServiceID == id)
                .all(decoding: ConfiguredProperty.self)
        }
    }
    
    override func findOneByAssignedService(id: Int) throws -> EventLoopFuture<ConfiguredProperty?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.assignedServiceID == id)
                .limit(1)
                .all(decoding: ConfiguredProperty.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByProperty(id: Int) throws -> EventLoopFuture<[ConfiguredProperty]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.propertyID == id)
                .all(decoding: ConfiguredProperty.self)
        }
    }
    
    override func findOneByProperty(id: Int) throws -> EventLoopFuture<ConfiguredProperty?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.propertyID == id)
                .limit(1)
                .all(decoding: ConfiguredProperty.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<[ConfiguredProperty]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.assignedServiceID == assignedServiceID)
                .where(\ConfiguredProperty.propertyID == propertyID)
                .all(decoding: ConfiguredProperty.self)
        }
    }
    
    override func findOneByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<ConfiguredProperty?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.assignedServiceID == assignedServiceID)
                .where(\ConfiguredProperty.propertyID == propertyID)
                .limit(1)
                .all(decoding: ConfiguredProperty.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByValue(value: String) throws -> EventLoopFuture<[ConfiguredProperty]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.value == value)
                .all(decoding: ConfiguredProperty.self)
        }
    }
    
    override func findOneByValue(value: String) throws -> EventLoopFuture<ConfiguredProperty?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredProperty.self)
                .where(\ConfiguredProperty.value == value)
                .limit(1)
                .all(decoding: ConfiguredProperty.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
