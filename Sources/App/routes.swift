import Vapor

/// Called when application is ready to set up endpoints.
public func routes(_ router: Router) throws {
    
    // Basic "Hello, world!" example
    router.get("ping") { req in
        return "{ \"message\" : \"OK\" }"
    }
    
}
