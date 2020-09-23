import Foundation
import Vapor

struct ConfiguredPropertyDto : Content {
    
    let id: Int
    let value: String // storing all as String for simplicity
    let createdAt: Int64
    let updatedAt: Int64
    
}

extension ConfiguredPropertyDto : Comparable {
    
    static func == (lhs: ConfiguredPropertyDto, rhs: ConfiguredPropertyDto) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func < (lhs: ConfiguredPropertyDto, rhs: ConfiguredPropertyDto) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: ConfiguredPropertyDto, rhs: ConfiguredPropertyDto) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func >= (lhs: ConfiguredPropertyDto, rhs: ConfiguredPropertyDto) -> Bool {
        return lhs.value >= rhs.value
    }
    
    static func > (lhs: ConfiguredPropertyDto, rhs: ConfiguredPropertyDto) -> Bool {
        return lhs.value > rhs.value
    }
    
}
