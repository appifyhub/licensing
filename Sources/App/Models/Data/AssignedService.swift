import Foundation

struct AssignedService : Hashable {
    
    let ID: Int
    let accountID: Int
    let serviceID: Int
    let assignedAt: Int64
    
}

extension AssignedService : Comparable {
    
    static func < (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID < rhs.ID
    }
    
    static func <= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID <= rhs.ID
    }
    
    static func >= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID >= rhs.ID
    }
    
    static func > (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID > rhs.ID
    }
    
}
