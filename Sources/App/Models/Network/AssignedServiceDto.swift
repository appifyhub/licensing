import Foundation
import Vapor

struct AssignedServiceDto : Content {
    
    let id: Int
    let assignedAt: Int64
    
    let configuredProperties: [ConfiguredPropertyDto]
    
}

extension AssignedServiceDto : Comparable {
    
    static func == (lhs: AssignedServiceDto, rhs: AssignedServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: AssignedServiceDto, rhs: AssignedServiceDto) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func <= (lhs: AssignedServiceDto, rhs: AssignedServiceDto) -> Bool {
        return lhs.id <= rhs.id
    }
    
    static func >= (lhs: AssignedServiceDto, rhs: AssignedServiceDto) -> Bool {
        return lhs.id >= rhs.id
    }
    
    static func > (lhs: AssignedServiceDto, rhs: AssignedServiceDto) -> Bool {
        return lhs.id > rhs.id
    }
    
}
