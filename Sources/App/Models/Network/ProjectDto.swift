import Foundation
import Vapor

struct ProjectDto : Content {
    
    let id: Int
    let name: String
    let type: String // opensource, commercial, free
    let status: String // review, active, blocked, suspended
    let createdAt: Int64
    let updatedAt: Int64
    
    let assignedServices: [AssignedServiceDto]
    
}

extension ProjectDto : Comparable {
    
    static func == (lhs: ProjectDto, rhs: ProjectDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: ProjectDto, rhs: ProjectDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <= (lhs: ProjectDto, rhs: ProjectDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func >= (lhs: ProjectDto, rhs: ProjectDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func > (lhs: ProjectDto, rhs: ProjectDto) -> Bool {
        return lhs.id == rhs.id
    }
    
}
