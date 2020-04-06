import Vapor

/// Called when application is ready to set up endpoints.
public func routes(_ router: Router) throws {
    
    // Basic 'alive' check
    router.get("ping") { req -> MessageResponse in
        return MessageResponse(message: "OK")
    }
    
    // TODO remove once real DAOs are ready
    struct MySQLVersion : Codable, Content {
        let version: String
    }
    router.get("sql") { req in
        return req.withPooledConnection(to: .mysql) { connection in
                connection.raw("SELECT @@version as version")
                    .all(decoding: MySQLVersion.self)
        }.map { rows in
            rows[0]
        }
    }
    
}
