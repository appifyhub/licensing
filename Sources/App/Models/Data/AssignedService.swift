import Foundation

final class AssignedService : Codable {
    
    let ID: Int?
    let accountID: Int
    let serviceID: Int
    let assignedAt: Int64
    
    init(
        ID: Int? = nil,
        accountID: Int,
        serviceID: Int,
        assignedAt: Int64
    ) {
        self.ID = ID
        self.accountID = accountID
        self.serviceID = serviceID
        self.assignedAt = assignedAt
    }
    
}

extension AssignedService : Comparable {
    
    static func == (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.accountID == rhs.accountID &&
            lhs.serviceID == rhs.serviceID
    }
    
    static func < (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.serviceID < rhs.serviceID
    }
    
    static func <= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.serviceID <= rhs.serviceID
    }
    
    static func >= (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.serviceID >= rhs.serviceID
    }
    
    static func > (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.serviceID > rhs.serviceID
    }
    
}
