import Vapor
import MySQL

/// Called when application is ready to set up endpoints.
public func routes(_ router: Router) throws {
    
    // TODO remove once real DAOs are ready
    struct MySQLVersion : Content {
        let version: String
    }
    router.get("sql") { req in
        return req.withPooledConnection(to: .mysql) { connection in
            return connection.raw("SELECT @@version as version")
                .all(decoding: MySQLVersion.self)
        }.map { rows in
            rows[0]
        }
    }
    
}
