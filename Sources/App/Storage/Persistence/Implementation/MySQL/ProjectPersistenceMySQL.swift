import Foundation
import Vapor
import MySQL

extension Project : SQLTable {}

class ProjectPersistenceMySQL : IProjectPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Project) throws -> EventLoopFuture<Project> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: Project.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<Project?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.ID == key)
                .limit(1)
                .all(decoding: Project.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: Project) throws -> EventLoopFuture<Project> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(Project.self)
                .set(newModel)
                .where(\Project.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: Project.self)
                .where(\Project.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[Project]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.accountID == id)
                .all(decoding: Project.self)
        }
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<Project?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.accountID == id)
                .limit(1)
                .all(decoding: Project.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[Project]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.name == name)
                .all(decoding: Project.self)
        }
    }
    
    override func findAllByType(_ type: Project.ProjectType) throws -> EventLoopFuture<[Project]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.type == type)
                .all(decoding: Project.self)
        }
    }
    
    override func findAllByStatus(_ status: Project.ProjectStatus) throws -> EventLoopFuture<[Project]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Project.self)
                .where(\Project.status == status)
                .all(decoding: Project.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
