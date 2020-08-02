import Foundation

final class AssignedService : Codable {
    
    let ID: Int?
    let projectID: Int
    let serviceID: Int
    let assignedAt: Int64
    
    init(
        ID: Int? = nil,
        projectID: Int,
        serviceID: Int,
        assignedAt: Int64
    ) {
        self.ID = ID
        self.projectID = projectID
        self.serviceID = serviceID
        self.assignedAt = assignedAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case projectID = "project_id"
        case serviceID = "service_id"
        case assignedAt = "assigned_at"
    }
    
}

// safe modifiers
extension AssignedService {
    
    func tryWithChangedID(_ newID: Int) -> AssignedService {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return AssignedService(
            ID: ID,
            projectID: self.projectID,
            serviceID: self.serviceID,
            assignedAt: self.assignedAt
        )
    }
    
}

extension AssignedService : Comparable {
    
    static func == (lhs: AssignedService, rhs: AssignedService) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.projectID == rhs.projectID &&
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
