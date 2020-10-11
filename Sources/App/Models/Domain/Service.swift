import Foundation

struct Service {
    
    var ID: Int
    var name: String
    var description: String
    var createdAt: Int64
    var updatedAt: Int64
    
    var assignedServices: [AssignedService] = []
    var properties: [Property] = []
    
}

extension Service : Comparable {
    
    static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    static func < (lhs: Service, rhs: Service) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Service, rhs: Service) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Service, rhs: Service) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Service, rhs: Service) -> Bool {
        return lhs.name > rhs.name
    }
    
}
