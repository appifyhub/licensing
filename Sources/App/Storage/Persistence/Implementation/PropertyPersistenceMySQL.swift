import Foundation
import Vapor
import MySQL

extension Property : SQLTable {}

class PropertyPersistenceMySQL : IPropertyPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Property) throws -> EventLoopFuture<Property> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: Property.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<Property?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Property.self)
                .where(\Property.ID == key)
                .limit(1)
                .all(decoding: Property.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: Property) throws -> EventLoopFuture<Property> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(Property.self)
                .set(newModel)
                .where(\Property.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: Property.self)
                .where(\Property.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[Property]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Property.self)
                .where(\Property.serviceID == id)
                .all(decoding: Property.self)
        }
    }
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[Property]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Property.self)
                .where(\Property.name == name)
                .all(decoding: Property.self)
        }
    }
    
    override func findAllByType(_ type: Property.PropertyType) throws -> EventLoopFuture<[Property]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Property.self)
                .where(\Property.type == type)
                .all(decoding: Property.self)
        }
    }
    
    override func findAllByMandatory(_ mandatory: Bool) throws -> EventLoopFuture<[Property]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Property.self)
                .where(\Property.mandatory == mandatory)
                .all(decoding: Property.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
