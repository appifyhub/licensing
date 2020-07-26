import Vapor
import MySQL

/// Called when application is ready to set up endpoints.
public func routes(_ router: Router) throws {
    
    router.get("/") { req in
        try (req as Request).view().render("index.html")
    }
    
}
