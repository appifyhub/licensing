import Foundation
import Vapor

struct PropertyDto : Content {
    
    let id: Int
    let name: String
    let type: String // integer, string, boolean, double
    let mandatory: Bool
    let createdAt: Int64
    let updatedAt: Int64
    
}

extension PropertyDto : Comparable {
    
    static func == (lhs: PropertyDto, rhs: PropertyDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: PropertyDto, rhs: PropertyDto) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func <= (lhs: PropertyDto, rhs: PropertyDto) -> Bool {
        return lhs.id <= rhs.id
    }
    
    static func >= (lhs: PropertyDto, rhs: PropertyDto) -> Bool {
        return lhs.id >= rhs.id
    }
    
    static func > (lhs: PropertyDto, rhs: PropertyDto) -> Bool {
        return lhs.id > rhs.id
    }
    
}
