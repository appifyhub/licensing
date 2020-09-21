import Foundation

struct AssignedService {
    
    var ID: Int
    var assignedAt: Int64
    
    var configuredProperties: [ConfiguredProperty] = []
    
}

extension AssignedService : Comparable {
    
    static func == (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    static func < (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.assignedAt < rhs.assignedAt
    }
    
    static func <= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.assignedAt <= rhs.assignedAt
    }
    
    static func >= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.assignedAt >= rhs.assignedAt
    }
    
    static func > (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.assignedAt > rhs.assignedAt
    }
    
}
