import Foundation

final class AssignedServiceDbm : Codable {
    
    let ID: Int?
    let projectID: Int
    let serviceID: Int
    let assignedAt: Int64
    
    init(
        ID: Int? = nil,
        projectID: Int,
        serviceID: Int,
        assignedAt: Int64 = 0
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
extension AssignedServiceDbm {
    
    func tryWithChangedID(_ newID: Int) -> AssignedServiceDbm {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return AssignedServiceDbm(
            ID: ID,
            projectID: self.projectID,
            serviceID: self.serviceID,
            assignedAt: self.assignedAt
        )
    }
    
    func withCurrentAssignmentTime(_ timeProvider: TimeProvider) -> AssignedServiceDbm {
        return AssignedServiceDbm(
            ID: ID,
            projectID: self.projectID,
            serviceID: self.serviceID,
            assignedAt: timeProvider.epochMillis()
        )
    }
    
}

extension AssignedServiceDbm : Comparable {
    
    static func == (lhs: AssignedServiceDbm, rhs: AssignedServiceDbm) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.projectID == rhs.projectID &&
            lhs.serviceID == rhs.serviceID
    }
    
    static func < (lhs: AssignedServiceDbm, rhs: AssignedServiceDbm) -> Bool {
        return lhs.serviceID < rhs.serviceID
    }
    
    static func <= (lhs: AssignedServiceDbm, rhs: AssignedServiceDbm) -> Bool {
        return lhs.serviceID <= rhs.serviceID
    }
    
    static func >= (lhs: AssignedServiceDbm, rhs: AssignedServiceDbm) -> Bool {
        return lhs.serviceID >= rhs.serviceID
    }
    
    static func > (lhs: AssignedServiceDbm, rhs: AssignedServiceDbm) -> Bool {
        return lhs.serviceID > rhs.serviceID
    }
    
}
