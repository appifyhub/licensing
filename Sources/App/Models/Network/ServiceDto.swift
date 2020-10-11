import Foundation
import Vapor

struct ServiceDto : Content {
    
    let id: Int
    let name: String
    let description: String
    let createdAt: Int64
    let updatedAt: Int64
    
    let properties: [PropertyDto]
    
}

extension ServiceDto : Comparable {
    
    static func == (lhs: ServiceDto, rhs: ServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: ServiceDto, rhs: ServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <= (lhs: ServiceDto, rhs: ServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func >= (lhs: ServiceDto, rhs: ServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func > (lhs: ServiceDto, rhs: ServiceDto) -> Bool {
        return lhs.id == rhs.id
    }
    
}
