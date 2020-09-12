import Foundation
import Vapor
import MySQL

extension AssignedService : SQLTable {}

class AssignedServicePersistenceMySQL : IAssignedServicePersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AssignedService) throws -> EventLoopFuture<AssignedService> {
        let newModel = model
            .withCurrentAssignmentTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: AssignedService.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<AssignedService?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.ID == key)
                .limit(1)
                .all(decoding: AssignedService.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: AssignedService) throws -> EventLoopFuture<AssignedService> {
        return success(model)
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: AssignedService.self)
                .where(\AssignedService.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByProject(id: Int) throws -> EventLoopFuture<[AssignedService]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.projectID == id)
                .all(decoding: AssignedService.self)
        }
    }
    
    override func findOneByProject(id: Int) throws -> EventLoopFuture<AssignedService?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.projectID == id)
                .limit(1)
                .all(decoding: AssignedService.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[AssignedService]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.serviceID == id)
                .all(decoding: AssignedService.self)
        }
    }
    
    override func findOneByService(id: Int) throws -> EventLoopFuture<AssignedService?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.serviceID == id)
                .limit(1)
                .all(decoding: AssignedService.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> EventLoopFuture<[AssignedService]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.projectID == projectID)
                .where(\AssignedService.serviceID == serviceID)
                .all(decoding: AssignedService.self)
        }
    }
    
    override func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> EventLoopFuture<AssignedService?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedService.self)
                .where(\AssignedService.projectID == projectID)
                .where(\AssignedService.serviceID == serviceID)
                .limit(1)
                .all(decoding: AssignedService.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
