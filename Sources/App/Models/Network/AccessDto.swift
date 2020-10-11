import Foundation
import Vapor

struct AccessDto : Content {
    
    let value: String
    let createdAt: Int64
    
}

extension AccessDto : Comparable {
    
    static func == (lhs: AccessDto, rhs: AccessDto) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func < (lhs: AccessDto, rhs: AccessDto) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: AccessDto, rhs: AccessDto) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func >= (lhs: AccessDto, rhs: AccessDto) -> Bool {
        return lhs.value >= rhs.value
    }
    
    static func > (lhs: AccessDto, rhs: AccessDto) -> Bool {
        return lhs.value > rhs.value
    }
    
}
